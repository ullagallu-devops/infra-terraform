# EKS Cluster
locals {
  name = "${var.environment}-${var.project_name}"
}

### EKS Control Plane
resource "aws_eks_cluster" "main" {
  name     = local.name
  version  = var.cluster_version
  role_arn = aws_iam_role.cluster.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs    = var.allowed_public_cidrs
    security_group_ids      = [aws_security_group.cluster.id]
  }
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
  )
}

resource "aws_eks_addon" "addons" {
  for_each                    = var.add_ons
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = each.key
  addon_version               = each.value
  resolve_conflicts_on_create = "OVERWRITE"
}

### EKS NodeGroup
resource "aws_eks_node_group" "nodes" {
  for_each = var.node_groups
  
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.subnet_ids

  instance_types = each.value.instance_types
  capacity_type  = each.value.capacity_type

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }
  depends_on = [
    aws_eks_cluster.main,
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.cloudwatch_logs,
    aws_security_group.cluster
  ]
}

#Security Group for EKS Cluster
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

module "eks-iam-access" {
  source = "./iam-user-group"
  for_each = var.eks-iam-access
  cluster_name      = aws_eks_cluster.main.name
  kubernetes_groups = each.value["kubernetes_groups"]
  principal_arn     = each.value["principal_arn"]
  policy_arn        = each.value["policy_arn"]
}