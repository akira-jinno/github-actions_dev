# ---------------------------------------------
# Terraform configuration
# ---------------------------------------------

terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.26"
    }
  }
  backend "s3" {
    bucket  = "terraform-test-trfstate"
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
# S3バケット作成
# ---------------------------------------------

resource "random_string" "s3_bucket_name" {
  length  = 6
  special = false
  upper   = false
}

module "s3_bucket" {
  source      = "./modules/s3"  # S3モジュールを参照
  bucket_name = "my-unique-bucket-${random_string.s3_bucket_name.result}"  # ランダム文字列を追加した一意のバケット名
  acl         = "private"        # ACL設定
  versioning  = true             # バージョニングを有効化
  environment = "dev"            # 環境タグ
}
