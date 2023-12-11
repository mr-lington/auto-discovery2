#create db subnet group
resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.prv-subnets
}

# Created MYSQL RDS
resource "aws_db_instance" "multi_az_rds" {
  allocated_storage           = 10
  db_subnet_group_name        = aws_db_subnet_group.rds_db_subnet_group.name
  engine                      = "mysql"
  engine_version              = "5.7"
  identifier                  = var.identifier
  instance_class              = "db.t2.micro"
  # multi_az                    = true
  db_name                     = var.db-name
  # username                    = var.username
  # password                    = var.password
  username                    = "petclinic"
  password                    = "petclinic"
  storage_type                = "gp2"
  vpc_security_group_ids      = [var.RDS-SG-ID]
  publicly_accessible         = true
  apply_immediately = true
  skip_final_snapshot         = false
  parameter_group_name        = "default.mysql5.7"
  max_allocated_storage = 100
}