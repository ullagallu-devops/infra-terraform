resource "null_resource" "kube-bootstrap" {
  depends_on = [module.eks]

  triggers = {
    cluster_name = module.eks.cluster_name
  }

  provisioner "local-exec" {
    command = <<EOF
aws eks update-kubeconfig --name ${module.eks.cluster_name}
EOF
    interpreter = ["/bin/bash", "-c"]
  }
}