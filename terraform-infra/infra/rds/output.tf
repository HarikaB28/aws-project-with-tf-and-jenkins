output "rds_address" {
  value       = aws_db_instance.default.address
  description = "The database endpoint address string"
}

