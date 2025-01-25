# ---------------------------------------------
# GitHub Actions 用の IAM ロール
# ---------------------------------------------

# GitHub Actions が AWS リソースにアクセスするための IAM ロールを作成
resource "aws_iam_role" "github_actions_role" {
  name               = "github-actions-dev-iam-role"  # IAM ロール名

  # IAM ロールの信頼ポリシー（Assume Role Policy）
  # GitHub Actions の Web Identity トークンを使ったロールの引き受けを許可
  assume_role_policy = jsonencode({
    Version = "2012-10-17"  # ポリシーのバージョン（固定値）
    Statement = [
      {
        Effect    = "Allow"  # アクセスを許可
        Principal = {
        #   Federated = data.aws_iam_openid_connect_provider.github.arn  # OIDC プロバイダーの ARN を指定
          Federated = aws_iam_openid_connect_provider.github.arn  # OIDC プロバイダーの ARN を指定
        }
        Action    = "sts:AssumeRoleWithWebIdentity"  # Web Identity トークンを使ったロールの引き受けを許可
        Condition = {
          # 条件を指定
          StringEquals = {
            # トークンの Audience が "sts.amazonaws.com" であることを確認
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"

            # トークンの Subject が指定した GitHub リポジトリパターンに一致することを確認
            # var.github_repo_pattern は変数で定義されたリポジトリパターンを参照
            "token.actions.githubusercontent.com:sub" = var.github_repo_pattern
          }
        }
      }
    ]
  })
}

# ---------------------------------------------
# IAM ロールにポリシーをアタッチ
# ---------------------------------------------

# 作成した IAM ロールに管理者アクセスポリシー（AdministratorAccess）をアタッチ
resource "aws_iam_role_policy_attachment" "github_actions_role_policy_attachment" {
  role       = aws_iam_role.github_actions_role.name  # アタッチ対象の IAM ロール
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"  # 管理者アクセス権限を付与
}
