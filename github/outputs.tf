# 作成したリポジトリのURLを出力
output "repository_url" {
  description = "The URL of the created repository"
  value       = github_repository.repo.html_url
}

# 作成したGitHub TeamのIDを出力
output "team_id" {
  description = "The ID of the created GitHub Team"
  value       = github_team.team.id
}

# # 作成したGitHub ProjectのURLを出力
# output "project_url" {
#   description = "The URL of the created GitHub Project"
#   value       = github_repository_project.project.url
# }

# GraphQL API化の対応
output "github_token" {
  description = "The GitHub Personal Access Token"
  value       = var.github_token
}