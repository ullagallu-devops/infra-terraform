variable "environment" {
  description = "Environment name"
  type        = string
}

variable "irsa_role_name" {
  description = "Name of the IAM role and policy"
  type        = string
}

variable "policy_statements" {
  description = "IAM policy statements for the role"
  type        = list(object({
    Effect   = string
    Action   = list(string)
    Resource = list(string)
  }))
  default = []
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "namespace" {
  description = "Namespace for the service account"
  type        = string
}

variable "service_account" {
  description = "Service account name"
  type        = string
}

variable "managed_policy_arns" {
  description = "List of managed policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}



