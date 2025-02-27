resource "null_resource" "kube-bootstrap" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = <<EOF
aws eks update-kubeconfig --name "$(echo ${module.eks.cluster_name} | tr -d '[:space:]')"
EOF
    interpreter = ["/bin/bash", "-c"]
  }
}
