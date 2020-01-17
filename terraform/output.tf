output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "rds_arn" {
  value = aws_db_instance.fitapp_rds_db.*.arn
}

output "mgmt_public_ip" {
  value = aws_instance.mgmt.public_ip
}

output "web1_public_ip" {
  value = aws_instance.web1.public_ip
}

output "web2_public_ip" {
  value = aws_instance.web2.public_ip
}
