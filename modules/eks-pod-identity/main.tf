resource "aws_iam_role" "this" {
  name = "${var.env}-eks-${var.name}-pod"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : ["pods.eks.amazonaws.com"]
        },
        "Action" : [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })

  inline_policy {
    name = "${var.name}-policy"

    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : var.policy_statements
    })
  }
}

resource "aws_eks_pod_identity_association" "this" {
  cluster_name    = var.cluster_name
  namespace       = var.namespace
  service_account = var.service_account
  role_arn        = aws_iam_role.this.arn
}
