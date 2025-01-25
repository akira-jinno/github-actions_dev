terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0" # 必要に応じてバージョン指定を調整
    }
  }
}

# GitHub providerの設定
provider "github" {
  # GitHub APIにアクセスするためのPersonal Access Tokenを設定
  token = var.github_token
  owner = var.organization_name
}

# GitHub Teamの作成
resource "github_team" "team" {
  # チーム名
  name = var.team_name
  # チームの説明T
  description = "Team for CI/CD development"
  # チームのプライバシー設定 (closed = 招待制)
  privacy = "closed"
  # organization = var.organization_name
}

# GitHub Repositoryの作成
resource "github_repository" "repo" {
  # リポジトリ名
  name = var.repository_name
  # リポジトリの説明
  description = "Repository for CI/CD development"
  # リポジトリの可視性 (public, private)
  visibility = var.repository_visibility
  # リポジトリを自動初期化
  auto_init = true
  # Issues, Projects, Wikiを有効にする
  has_issues   = true
  has_projects = true
  has_wiki     = true
}

# 作成したGitHub Teamをリポジトリに関連付ける
resource "github_team_repository" "team_repo" {
  # チームID
  team_id = github_team.team.id
  # リポジトリ名
  repository = github_repository.repo.name
  # チームの権限設定 (例: admin, push, pull, maintain, triage)
  permission = var.team_repository_permission
}

# GraphQL APIを利用したProjects (Beta)作成
resource "null_resource" "create_project" {
  provisioner "local-exec" {
    command = "bash ../scripts/create_project.sh ${var.organization_name} ${var.project_name}"
  }
}

# # GitHub Projectの作成
# resource "github_repository_project" "project" {
#   # プロジェクト名
#   name       = var.project_name
#   # プロジェクトの説明
#   body       = "Project for managing CI/CD tasks"
#   # プロジェクトを紐付けるリポジトリ
#   repository = github_repository.repo.name
# }

# GitHub リポジトリのブランチ保護設定
resource "github_branch_protection_v3" "branch_protection" {
  # 対象リポジトリ名
  repository = github_repository.repo.name
  # 対象ブランチ (ここでは 'main' ブランチ)
  branch = "main"
  # 管理者にも強制するかどうか
  enforce_admins = true

  # プルリクエストのレビュー設定
  required_pull_request_reviews {
    # 古いレビューを無効にする
    dismiss_stale_reviews = true
    # コードオーナーによるレビューが必要か
    require_code_owner_reviews = var.require_code_owner_reviews
    # 承認されるべきレビュー数
    required_approving_review_count = var.required_approving_review_count
  }

  # プッシュ制限設定
  restrictions {
    # 限定的なユーザーのリスト (例: 特定ユーザーにのみプッシュ許可)
    users = var.restricted_users
    # 限定的なチーム (ここでは作成したチーム)
    teams = [github_team.team.slug]
  }
}