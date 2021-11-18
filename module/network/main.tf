# vpc
module "vpc" {
  source               = "../../resource/vpc"
  vpc_name             = "vpc"
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags                 = var.tags
}

# insternet_gateway
module "internet_gateway" {
  source                = "../../resource/internet-gateway"
  internet_gateway_name = "igw"
  vpc_id                = module.vpc.vpc_id
  tags                  = var.tags
}

# subnet(public)
module "subnet_public" {
  source = "../../resource/subnet"
  vpc_id = module.vpc.vpc_id
  subnets = {
    pub-a = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = data.aws_availability_zones.this.names[0]
    },
    pub-b = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = data.aws_availability_zones.this.names[1]
    }
  }
  tags = var.tags
}

# route_table(public)
module "route_table_public" {
  source           = "../../resource/route_table"
  route_table_name = "rtb_pub"
  vpc_id           = module.vpc.vpc_id
  route = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.internet_gateway.internet_gateway_id
    }
  ]

  subnet_ids = module.subnet_public.subnet_ids
  tags       = var.tags
}

# subnet(private)
module "subnet_private" {
  source = "../../resource/subnet"
  vpc_id = module.vpc.vpc_id
  subnets = {
    pri-a = {
      cidr_block        = "10.0.51.0/24"
      availability_zone = data.aws_availability_zones.this.names[0]
    },
    pri-b = {
      cidr_block        = "10.0.52.0/24"
      availability_zone = data.aws_availability_zones.this.names[1]
    }
  }
  tags = var.tags
}

# route_table(private)
module "route_table_private" {
  source           = "../../resource/route_table"
  route_table_name = "rtb_pri"
  vpc_id           = module.vpc.vpc_id
  route            = []

  subnet_ids = module.subnet_private.subnet_ids
  tags       = var.tags
}

# subnet(private_rds)
module "subnet_private_rds" {
  source = "../../resource/subnet"
  vpc_id = module.vpc.vpc_id
  subnets = {
    pri-a = {
      cidr_block        = "10.0.101.0/24"
      availability_zone = data.aws_availability_zones.this.names[0]
    },
    pri-b = {
      cidr_block        = "10.0.102.0/24"
      availability_zone = data.aws_availability_zones.this.names[1]
    }
  }
  tags = var.tags
}

# route_table(private)
module "route_table_private_rds" {
  source           = "../../resource/route_table"
  route_table_name = "rtb_pri_rds"
  vpc_id           = module.vpc.vpc_id
  route            = []

  subnet_ids = module.subnet_private_rds.subnet_ids
  tags       = var.tags
}