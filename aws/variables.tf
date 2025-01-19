# ---------------------------------------------
# AWS設定に関する変数
# ---------------------------------------------

variable "aws_profile" {
  description = "The AWS CLI profile name to use"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

# ---------------------------------------------
# S3バケットに関する変数
# ---------------------------------------------

variable "backend_s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "acl" {
  description = "The ACL policy for the S3 bucket"
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment tag for the S3 bucket"
  type        = string
}


# variable "terraform_state_bucket" {
#   description = "The name of the S3 bucket used for Terraform state"
#   type        = string
# }
