output "terraform_state_bucket_name" {
  description = "ID of the first S3 bucket"
  value = aws_s3_bucket.terraform_state.bucket
}

output "terraform_state_bucket_arn" {
  description = "ID of the second S3 bucket"
  value = aws_s3_bucket.terraform_state.arn
}
