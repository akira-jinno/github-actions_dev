#!/bin/bash

ORGANIZATION_NAME=$1
PROJECT_NAME=$2

# GitHub GraphQL APIエンドポイント
API_URL="https://api.github.com/graphql"

# Personal Access Token（terraform.tfvars で設定された token を使用）
TOKEN=$(terraform output -raw github_token)

# GraphQLクエリをJSON形式で作成
QUERY=$(cat <<EOF
{
  "query": "mutation {\n    createProjectV2(input: {ownerId: \"${ORGANIZATION_NAME}\", title: \"${PROJECT_NAME}\"}) {\n      projectV2 {\n        id\n      }\n    }\n  }"
}
EOF
)

# GraphQL APIを呼び出し
curl -X POST -H "Authorization: bearer $TOKEN" -H "Content-Type: application/json" -d "$QUERY" $API_URL

# このスクリプトは、指定された組織の下にProjects (Beta)を作成します。

