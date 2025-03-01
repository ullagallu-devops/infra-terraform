resource "kubernetes_storage_class" "ebs" {
  metadata {
    name = var.storage_class_name
  }

  storage_provisioner = "ebs.csi.aws.com"

  parameters = {
    type                         = "gp3"
    encrypted                    = "true"
    "csi.storage.k8s.io/fstype"  = "xfs"
  }

  reclaim_policy      = "Delete"
  volume_binding_mode = "WaitForFirstConsumer"
  allow_volume_expansion = true
}


variable "storage_class_name"{}