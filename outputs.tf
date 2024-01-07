output "kms_key" {
  description = "all exported kms key attributes"
  value       = aws_kms_key.primary_key
}

output "kms_replica_key" {
  description = "all exported kms replica key attributes"
  value       = aws_kms_replica_key.replica_key
}