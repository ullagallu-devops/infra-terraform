locals{
    name = "${var.environment}-${var.project_name}"
}

# Control Plane
resource "aws_eks_cluster" "example" {
  name = "${local.name}-cluster"

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  role_arn = aws_iam_role.cluster.arn
  version  = "1.31"

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids = var.subnets
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    security_group_ids  = [aws_security_group.cluster.id]
    public_access_cidrs = var.public_access_cidrs
  }
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]

  tags = merge(
    {
        Name = local.name
    },
    var.common_tags
  )
}

#Security Group for EKS Control Plane
resource "aws_security_group" "cluster" {
  name        = "${var.environment}-${var.project_name}"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-${var.project_name}"
  }
}

# Add-ons
# resource "aws_eks_addon" "example" {
#   for_each = var.addons
#   cluster_name                = aws_eks_cluster.example.name
#   addon_name                  = each.key
#   addon_version               = each.value
#   resolve_conflicts_on_create = "OVERWRITE"
# }

# nodeGroup
resource "aws_launch_template" "main" {
  for_each = var.node_groups
  name     = each.key

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      encrypted   = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = each.key
    }
  }
}

resource "aws_eks_node_group" "example" {
  for_each = var.node_groups
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "${local.name}-node"
  node_role_arn   = aws_iam_role.example.arn
  subnet_ids      = var.subnets
  instance_types = each.value["instance_types"]
  capacity_type   = each.value["capacity_type"]

  scaling_config {
    desired_size = each.value["desired_size"]
    max_size     = each.value["max_size"]
    min_size     = each.value["min_size"]
  }

  launch_template {
    name    = each.key
    version = "$Latest"
  }

  depends_on = [aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy]
}