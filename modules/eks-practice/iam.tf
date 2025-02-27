# Control Plane IAM Role and Policy
resource "aws_iam_role" "cluster" {
  name = "${local.name}-control-plane"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  for_each = toset([
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ])
  policy_arn = each.value
  role       = aws_iam_role.cluster.name
}

# NodeGroup IAM Role and Policy
resource "aws_iam_role" "example" {
  name = "${local.name}-nodegroup"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])
  policy_arn = each.value
  role       = aws_iam_role.example.name
}

resource "aws_iam_policy" "policy" {
  name        = "${local.name}-EBS-CSI-Policy"
  description = "This is EBS CSI Driver to Provision EBS volumes on behalf of EKS"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshots",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DescribeVolumesModifications"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateSnapshot",
          "ec2:ModifyVolume"
        ],
        "Resource" : "arn:aws:ec2:*:*:volume/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:AttachVolume",
          "ec2:DetachVolume"
        ],
        "Resource" : [
          "arn:aws:ec2:*:*:volume/*",
          "arn:aws:ec2:*:*:instance/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateVolume",
          "ec2:EnableFastSnapshotRestores"
        ],
        "Resource" : "arn:aws:ec2:*:*:snapshot/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateTags"
        ],
        "Resource" : [
          "arn:aws:ec2:*:*:volume/*",
          "arn:aws:ec2:*:*:snapshot/*"
        ],
        "Condition" : {
          "StringEquals" : {
            "ec2:CreateAction" : [
              "CreateVolume",
              "CreateSnapshot"
            ]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteTags"
        ],
        "Resource" : [
          "arn:aws:ec2:*:*:volume/*",
          "arn:aws:ec2:*:*:snapshot/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateVolume"
        ],
        "Resource" : "arn:aws:ec2:*:*:volume/*",
        "Condition" : {
          "StringLike" : {
            "aws:RequestTag/ebs.csi.aws.com/cluster" : "true"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateVolume"
        ],
        "Resource" : "arn:aws:ec2:*:*:volume/*",
        "Condition" : {
          "StringLike" : {
            "aws:RequestTag/CSIVolumeName" : "*"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteVolume"
        ],
        "Resource" : "arn:aws:ec2:*:*:volume/*",
        "Condition" : {
          "StringLike" : {
            "ec2:ResourceTag/ebs.csi.aws.com/cluster" : "true"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteVolume"
        ],
        "Resource" : "arn:aws:ec2:*:*:volume/*",
        "Condition" : {
          "StringLike" : {
            "ec2:ResourceTag/CSIVolumeName" : "*"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteVolume"
        ],
        "Resource" : "arn:aws:ec2:*:*:volume/*",
        "Condition" : {
          "StringLike" : {
            "ec2:ResourceTag/kubernetes.io/created-for/pvc/name" : "*"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateSnapshot"
        ],
        "Resource" : "arn:aws:ec2:*:*:snapshot/*",
        "Condition" : {
          "StringLike" : {
            "aws:RequestTag/CSIVolumeSnapshotName" : "*"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateSnapshot"
        ],
        "Resource" : "arn:aws:ec2:*:*:snapshot/*",
        "Condition" : {
          "StringLike" : {
            "aws:RequestTag/ebs.csi.aws.com/cluster" : "true"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteSnapshot"
        ],
        "Resource" : "arn:aws:ec2:*:*:snapshot/*",
        "Condition" : {
          "StringLike" : {
            "ec2:ResourceTag/CSIVolumeSnapshotName" : "*"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DeleteSnapshot"
        ],
        "Resource" : "arn:aws:ec2:*:*:snapshot/*",
        "Condition" : {
          "StringLike" : {
            "ec2:ResourceTag/ebs.csi.aws.com/cluster" : "true"
          }
        }
      }
    ]

  })
}


resource "aws_iam_policy_attachment" "test-attach" {
  name       = "EBS-CSI-DRIVER-Attachment"
  roles      = [aws_iam_role.example.name]
  policy_arn = aws_iam_policy.policy.arn
}

