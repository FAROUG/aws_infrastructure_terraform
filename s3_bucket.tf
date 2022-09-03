resource "random_string" "random" {
  length  = 5
  special = false
  lower   = true
  upper   = false
  #   override_special = "/@£$"
}

resource "aws_s3_bucket" "AWS_S3_BUCKET" {
  bucket = format("%s-%s", "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_RESOURCE_BUCKET_NAME}", random_string.random.result)
  #   acl    = var.acl_value
}

resource "aws_s3_object" "file_upload" {
  bucket = aws_s3_bucket.AWS_S3_BUCKET.bucket
  key    = var.AWS_SSH_ZIP_FILE_NAME
  source = "${path.module}/${var.BASH_SCRIPTS_FOLDER_PATH}/${var.BASH_SCRIPTS_ZIP_FILE}"
  etag   = filemd5("${path.module}/${var.BASH_SCRIPTS_FOLDER_PATH}/${var.BASH_SCRIPTS_ZIP_FILE}")
  #   etag   = filebase64("${path.module}/bash-scripts/id_rsa"
}

output "AWS_S3_BUCKET_RESOURCE_NAME" {
  value = aws_s3_bucket.AWS_S3_BUCKET.bucket
}
# output "RANDOM_STRING_OUTPUT" {
#   value = random_string.random.result
# }
output "AWS_S3_OBJECT_OUTPUT" {
  value = aws_s3_object.file_upload.id
}
