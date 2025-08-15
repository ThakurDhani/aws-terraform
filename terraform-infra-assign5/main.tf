provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  name     = "Assignment5-VPC"
}

module "subnet" {
  source     = "./modules/subnet"
  vpc_id     = module.vpc.vpc_id
  cidr_block = var.subnet_cidr
  az         = var.az
  public_ip  = true
  name       = "public-subnet"
}

module "igw" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
  name   = "A5-igw"
}

module "route_table" {
  source    = "./modules/route_table"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.subnet.subnet_id
  igw_id    = module.igw.igw_id
  name      = "A5-rt"
}

module "sg" {
  source      = "./modules/security_group"
  vpc_id      = module.vpc.vpc_id
  name        = "Assign5-SG"
  description = "Allow SSH and HTTP"
}

module "ec2" {
  source        = "./modules/ec2"
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.subnet.subnet_id
  sg_id         = module.sg.sg_id
  name          = "Assign5-Server"
}
