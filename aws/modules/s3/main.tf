resource "aws_s3_bucket" "s3_backend_bucket" {
  bucket = var.bucket_name  # 外部から渡されたバケット名を利用

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
