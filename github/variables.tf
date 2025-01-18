# GitHub Personal Access Token
variable "github_token" {
  description = "Personal Access Token for GitHub API"
  type        = string
}

variable "organization_name" {
  description = "The name of the GitHub Organization"
  type        = string
  # default     = "my-org"
}

variable "organization_id" {
  description = "The ID of the GitHub Organization"
  type        = string
}

# GitHub Team名
variable "team_name" {
  description = "The name of the GitHub Team"
  type        = string
  default     = "cicd-dev-team"
}

# GitHub Repository名
variable "repository_name" {
  description = "The name of the GitHub Repository"
  type        = string
  default     = "cicd-dev-repo"
}

# GitHubリポジトリの可視性 (public, private, internal)
variable "repository_visibility" {
  description = "The visibility of the GitHub Repository (public, private, or internal)"
  type        = string
  default     = "public"
}

# GitHub Project名
variable "project_name" {
  description = "The name of the GitHub Project"
  type        = string
  default     = "cicd-dev-project"
}

# GitHub Teamに対するリポジトリ権限 (admin, push, pull など)
variable "team_repository_permission" {
  description = "The permission level for the team on the repository (pull, push, admin, maintain, or triage)"
  type        = string
  default     = "admin"
}

# プルリクエストのレビューに必要な承認数
variable "required_approving_review_count" {
  description = "Number of approvals required for a PR to be merged"
  type        = number
  default     = 1
}

# コードオーナーのレビューを必須にするかどうか
variable "require_code_owner_reviews" {
  description = "Require code owner reviews before merging"
  type        = bool
  default     = true
}

# プッシュを許可するユーザーリスト
variable "restricted_users" {
  description = "List of users allowed to push to protected branches"
  type        = list(string)
  default     = []
}
