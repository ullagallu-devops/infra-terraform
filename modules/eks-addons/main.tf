# Add-ons
resource "aws_eks_addon" "example" {
  for_each = var.addons
  cluster_name                = var.cluster_name
  addon_name                  = each.key
  addon_version               = each.value
  resolve_conflicts_on_create = "OVERWRITE"
}

variable "addons"{}
variable "cluster_name"{}


