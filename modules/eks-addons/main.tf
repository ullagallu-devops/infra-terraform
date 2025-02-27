# Add-ons
resource "aws_eks_addon" "example" {
  for_each = var.addons
  cluster_name                = aws_eks_cluster.example.name
  addon_name                  = each.key
  addon_version               = each.value
  resolve_conflicts_on_create = "OVERWRITE"
}

variable "addons"{}


