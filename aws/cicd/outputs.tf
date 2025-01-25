# ---------------------------------------------
# GitHub Actions 用 IAM ロールの ARN 出力
# ---------------------------------------------

# 作成された IAM ロールの ARN を出力
# output "github_actions_role_arn" {
#   description = "ARN of the IAM role for GitHub Actions"
#   value       = aws_iam_role.github_actions_role.arn
# }

# 作成された OIDC プロバイダーの ARN を出力
output "github_oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider"
  value       = aws_iam_openid_connect_provider.github.arn
}
