resource "null_resource" "kube-bootstrap" {
  depends_on = [module.eks]  
  
  provisioner "local-exec" {
    command = <<EOF
    aws eks update-kubeconfig \
      --region ${var.region} \
      --name ${module.eks.cluster_name}
EOF
  }
}