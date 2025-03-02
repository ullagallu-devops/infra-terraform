resource "null_resource" "kube-bootstrap" {
  depends_on = [module.eks]
  # triggers = {
  #   always_run = timestamp()
  # }
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ap-south-1 --name ${module.eks.cluster_name}"
  }
}
# resource "null_resource" "kube-ns" {
#   # triggers = {
#   #   always_run = timestamp()
#   # }

#   provisioner "local-exec" {
#     command = <<EOT
#       kubectl create ns expense || true
#       kubectl create ns instana || true
#     EOT
#   }
# }
resource "helm_release" "ebs_csi_driver" {
  depends_on = [null_resource.kube-bootstrap]
  name       = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  create_namespace = false
}

resource "helm_release" "alb_ingress_controller" {
  depends_on = [null_resource.kube-bootstrap]
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  create_namespace = false
}