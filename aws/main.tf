# ---------------------------------------------
# Terraform configuration
# ---------------------------------------------

terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.76"
    }
  }
  backend "s3" {
    bucket  = "tf-s3-backend-n80ddd" #"terraform-test-trfstate"
    key     = "github-action_test.tfstate"
    region  = "ap-northeast-1"
    profile = "tf-sso_profile"
  }
}

# ---------------------------------------------
# Provider
# ---------------------------------------------

# 使用するAWSプロファイルとリージョン
provider "aws" {
  profile = var.aws_profile
  region  = var.region
}

# ---------------------------------------------
# S3バケット作成（Terraform backend用）
# ---------------------------------------------

resource "random_string" "s3_bucket_name" {
  length  = 6
  special = false
  upper   = false
}

# # Terraform backend用のS3バケット
# module "s3_bucket" {
#   source      = "./modules/s3"  # S3モジュールを参照
#   backend_s3_bucket_name = "${var.backend_s3_bucket_name}-${random_string.s3_bucket_name.result}"  # ランダム文字列を追加した一意のバケット名
#   acl         = "private"        # ACL設定
#   versioning  = true             # バージョニングを有効化
#   environment = "dev"            # 環境タグ
# }

# ---------------------------------------------
# GHA用S3バケット作成
# ---------------------------------------------

# GHA用S3バケットモジュールの呼び出し
module "gha_s3" {
  source          = "./modules/s3"                                      # S3モジュールを再利用
  gha_bucket_name = "gha-bucket-${random_string.s3_bucket_name.result}" # IAM用バケット名
  acl             = "private"                                           # IAM用バケットのACL
  versioning      = true                                                # IAM用バケットのバージョニングを有効化
  environment     = "dev"                                               # 環境タグ
}

# ---------------------------------------------
# CI/CD関連モジュール作成
# ---------------------------------------------

module "cicd" {
  source                   = "./cicd"
  github_oidc_provider_arn = var.github_oidc_provider_arn
  # github_oidc_provider_arn = data.aws_iam_openid_connect_provider.github.arn
  github_repo_pattern = var.github_repo_pattern # 必須変数を渡す
  aws_account_id      = var.aws_account_id      # 必須変数を渡す
}
