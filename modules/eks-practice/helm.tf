resource "null_resource" "kube-bootstrap" {
  depends_on = [aws_eks_cluster.example]

  provisioner "local-exec" {
    command = <<EOF
aws eks update-kubeconfig --name ${aws_eks_cluster.example.name}
kubectl create ns siva
echo "Cluster setup completed"
EOF
  }
}