# EKS Cluster IAM Role
resource "aws_iam_role" "cluster" {
  name = "${var.environment}-${var.project_name}-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}
resource "aws_iam_role_policy_attachment" "control_plane_policy"{
   for_each = toset([
      "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
      "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
      "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
   ])
   policy_arn = each.value
   role = aws_iam_role.cluster.name
}

# # Node Group IAM Role
resource "aws_iam_role" "node_group" {
  name = "${var.environment}-${var.project_name}-node-group"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "node_group_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
    "arn:aws:iam::522814728660:policy/AllowExternalDNSUpdates",
    "arn:aws:iam::522814728660:policy/AWSLoadBalancerControllerIAMPolicy"
  ])

  policy_arn = each.value
  role       = aws_iam_role.node_group.name
}