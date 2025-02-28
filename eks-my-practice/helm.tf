resource "null_resource" "kube-bootstrap" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = <<EOF
      aws eks update-kubeconfig --name ${module.eks.cluster_name} 
      export KUBECONFIG=~/.kube/config
    EOF
  }

  triggers = {
    cluster_name = module.eks.cluster_name
  }
}

resource "helm_release" "ebs_csi_driver" {
  depends_on = [null_resource.kube-bootstrap]
  name       = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  create_namespace = false

  set {
    name  = "serviceAccount.create"
    value = "true"
  }
}
