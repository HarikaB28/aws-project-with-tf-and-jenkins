variable "db_subnet_group_name" {}
variable "subnet_groups" {}
variable "rds_mysql_sg_id" {}
variable "mysql_db_identifier" {}
variable "mysql_username" {}
variable "mysql_password" {}
variable "mysql_dbname" {}

# RDS Subnet Group
resource "aws_db_subnet_group" "dev_proje_1_db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_groups 
}

resource "aws_db_instance" "default" {
  allocated_storage       = 20               # 20 GB is standard for Free Tier
  storage_type            = "gp2"            # Correct Free Tier storage type
  engine                  = "mysql"
  engine_version          = "8.0"            # CHANGE: Avoids expensive MySQL 5.7 Extended Support fees
  instance_class          = "db.t3.micro"    # CHANGE: Switched to t3.micro for modern region compatibility
  identifier              = var.mysql_db_identifier
  username                = var.mysql_username
  password                = var.mysql_password
  vpc_security_group_ids  = [var.rds_mysql_sg_id]
  db_subnet_group_name    = aws_db_subnet_group.dev_proje_1_db_subnet_group.name
  db_name                 = var.mysql_dbname
  
  # Strict Free Tier Safety Configurations
  multi_az                = false            # Must be single-AZ
  skip_final_snapshot     = true
  apply_immediately       = true
  backup_retention_period = 0                # Keeps backup costs at zero
  deletion_protection     = false
}

