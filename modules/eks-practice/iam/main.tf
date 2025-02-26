resource "aws_eks_access_entry" "example" {
  cluster_name      = var.cluster_name
  principal_arn     = var.principal_arn
  kubernetes_groups = var.k8s_groups
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "example" {
  depends_on = [aws_eks_access_entry.example]
  cluster_name  = var.cluster_name
  policy_arn    = var.policy_arn
  principal_arn = var.principal_arn

  access_scope {
    type = var.access_scope_type

     namespaces = var.access_scope_type == "namespace" ? var.namespaces : null
  }
}


# Variables
variable "cluster_name"{}
variable "principal_arn"{}
variable "k8s_groups"{}
variable "policy_arn"{}
variable "access_scope_type"{}
variable "namespaces"{
    default = []
}

