resource "aws_s3_bucket" "s3_backend_bucket" {
  bucket = var.backend_s3_bucket_name  # 外部から渡されたバケット名を利用

  tags = {
    Environment = var.environment
  }
}

# ---------------------------------------------
# S3バケットのバージョニング設定
# ---------------------------------------------

resource "aws_s3_bucket_versioning" "s3_backend_bucket" {
  bucket = aws_s3_bucket.s3_backend_bucket.bucket  # 作成したS3バケットを参照

  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

# # ---------------------------------------------
# # IAM用S3バケット設定
# # ---------------------------------------------

# # IAM用のS3バケット
# resource "aws_s3_bucket" "iam_oidc_bucket" {
#   bucket = var.bucket_name  # モジュール呼び出し時に指定されたバケット名

#   acl = var.acl  # ACL設定

#   tags = {
#     Environment = var.environment
#     Module      = "IAM"
#   }
# }

# # IAM用S3バケットのバージョニング設定
# resource "aws_s3_bucket_versioning" "iam_oidc_bucket" {
#   bucket = aws_s3_bucket.iam_oidc_bucket.id  # 作成したIAM用バケットを参照

#   versioning_configuration {
#     status = var.versioning ? "Enabled" : "Suspended"
#   }
# }