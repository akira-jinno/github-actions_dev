# ---------------------------------------------
# GitHub Actions用 OIDC プロバイダー ARN
# ---------------------------------------------

# AWS アカウント ID（OIDC プロバイダーの ARN に使用）aws/variables.tfと重複のため削除予定
variable "aws_account_id" {
  description = "AWS アカウント ID"
  type        = string
}

# GitHub OIDC プロバイダー URL
# variable "github_oidc_provider_url" {
#   description = "GitHub Actions 用の OIDC プロバイダー URL"
#   type        = string
#   default     = "https://token.actions.githubusercontent.com"
# }

# GitHub OIDC プロバイダーの ARN を渡す変数
variable "github_oidc_provider_arn" {
  description = "GitHub OIDC provider ARN for setting up CI/CD roles"
  type        = string
}

# GitHub リポジトリの識別用パターン aws/cicd/main.tfで使用
variable "github_repo_pattern" {
  description = "GitHub repository pattern for the CI/CD role (e.g., repo:<organization_name>/<repo_name> or repo:<organization_name>/*)"
  type        = string
}
