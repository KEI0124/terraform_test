# security_group(db)
module "sgr_rds" {
  source = "../../resource/security_group"
  name   = "sgr-rds"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  ingress_rule = {
    1 = {
      description = "sgr-rds"
      from_port   = 1433,
      to_port     = 1433,
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = var.tags
}


# db
module "db" {
  source = "../../resource/rds"

  identifier = "rds-mssql"

  engine                  = "sqlserver-se"
  instance_class          = "db.m5.large"
  engine_version          = "11.00.5058.0.v1"
  allocated_storage       = 20
  multi_az                = true
  license_model           = "license-included"
  backup_retention_period = 5

  #database_name = "mssql"
  database_user     = "sattadmin"
  database_password = "satt-admin-passw0rd!"
  database_port     = "1433"

  security_group_ids = [module.sgr_rds.security_group_id]
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  tags = var.tags

  subnet_ids           = data.terraform_remote_state.network.outputs.private_subnet_ids_rds
  major_engine_version = "11.00"
}