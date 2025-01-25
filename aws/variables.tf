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

# variable "backend_s3_bucket_name" {
#   description = "The name of the S3 bucket"
#   type        = string
# }

# variable "gha_bucket_name" {
#   description = "The name of the S3 bucket"
#   type        = string
# }

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


# ---------------------------------------------
# GitHub Actions用 OIDC プロバイダー ARN
# ---------------------------------------------

# AWS アカウント ID（OIDC プロバイダーの ARN に使用） aws/main.tfで使用
variable "aws_account_id" {
  description = "AWS アカウント ID"
  type        = string
}

# GitHub OIDC プロバイダー URL
variable "github_oidc_provider_url" {
  description = "GitHub Actions 用の OIDC プロバイダー URL"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

# GitHub OIDC プロバイダーの ARN を渡す変数
variable "github_oidc_provider_arn" {
  description = "GitHub OIDC provider ARN for setting up CI/CD roles"
  type        = string
}

# GitHub リポジトリの識別用パターン  いらないかも？
variable "github_repo_pattern" {
  description   = "GitHub repository pattern for the CI/CD role (e.g., repo:<organization_name>/<repo_name> or repo:<organization_name>/*)"
  type        = string
}
