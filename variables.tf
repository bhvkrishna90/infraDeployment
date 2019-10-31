variable "aws_region" {
    type = string
}
variable "az1" {
    type = string
}
variable "az2" {
    type = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
}


variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
  default     = "1.14"
}

variable "iamrole_Name" {
  description = "IAM Role Name"
  type        = string
}
