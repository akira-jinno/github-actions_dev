# ---------------------------------------------
# OIDC プロバイダーの ARN を取得するデータソース
# ---------------------------------------------

# AWS IAM OIDC プロバイダーの ARN をデータソースとして取得
# data "aws_iam_openid_connect_provider" "github" {
#   arn = "arn:aws:iam::${var.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"  # 必要に応じて置き換え
# }

# ---------------------------------------------
# 出力値の設定
# ---------------------------------------------

# # OIDC プロバイダー ARN を出力
# output "github_oidc_provider_arn" {
#   value       = data.aws_iam_openid_connect_provider.github.arn
#   description = "GitHub Actions 用の OIDC プロバイダー ARN"
# }

# ---------------------------------------------
# OIDC プロバイダーの ARN を取得するリソース
# ---------------------------------------------

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com" # GitHub OIDC プロバイダー URL
  client_id_list  = ["sts.amazonaws.com"]                         # GitHub Actions 用の標準的なクライアントID
  thumbprint_list = ["9e99a48a9960a6bb5e7a7e49ca2922d3c41b3c1b"]  # GitHub OIDC サムプリント
}