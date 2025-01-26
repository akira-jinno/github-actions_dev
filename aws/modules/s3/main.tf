# ---------------------------------------------
# GHA用S3バケット設定
# ---------------------------------------------
resource "aws_s3_bucket" "gha_bucket" {
  bucket = var.gha_bucket_name # モジュール呼び出し時に指定されたバケット名

  tags = {
    Environment = var.environment
    Module      = "IAM"
  }
}


# GHA用S3バケットのバージョニング設定
resource "aws_s3_bucket_versioning" "gha_bucket_bucket" {
  bucket = aws_s3_bucket.gha_bucket.id # 作成したGHA用バケットを参照

  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}


# resource "aws_s3_bucket" "s3_backend_bucket" {
#   bucket = var.backend_s3_bucket_name  # 外部から渡されたバケット名を利用

#   tags = {
#     Environment = var.environment
#   }
# }

# # ---------------------------------------------
# # S3バケットのバージョニング設定
# # ---------------------------------------------

# resource "aws_s3_bucket_versioning" "s3_backend_bucket" {
#   bucket = aws_s3_bucket.s3_backend_bucket.bucket  # 作成したS3バケットを参照

#   versioning_configuration {
#     status = var.versioning ? "Enabled" : "Suspended"
#   }
# }

