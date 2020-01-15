# Terraform template to deploy fitapp in HA configuration and provision various resources.

resource "aws_vpc" "VPC" {
    cidr_block                = "10.0.0.0/16"   # Defines overall VPC address space
    enable_dns_hostnames      = true            # Enable DNS hostnames for this VPC
    enable_dns_support        = true            # Enable DNS resolving support for this VPC
    tags = {
        Name                  = "VPC-${var.environment}" # Tag VPC with name
        Product               = var.product
        Team                  = var.team
        Owner                 = var.owner
        Environment           = var.environment
        Organization          = var.organization
        "Cost Center"         = var.costcenter
    }
}

resource "aws_subnet" "public-web-az-a" {
    availability_zone         = "us-east-1a"    # Define AZ for subnet
    cidr_block                = "10.0.1.0/24"   # Define CIDR-block for subnet
    map_public_ip_on_launch   = true            # Map public IP to deployed instances in this VPC
    vpc_id                    = aws_vpc.vpc.id  # Link Subnet to VPC
    tags = {
        Name                  = "Subnet-US-East-1a-Web" # Tag subnet with name
        Product               = var.product
        Team                  = var.team
        Owner                 = var.owner
        Environment           = var.environment
        Organization          = var.organization
        "Cost Center"         = var.costcenter
    }
}

resource "aws_subnet" "public-web-az-c" {
    availability_zone         = "us-east-1a"    # Define AZ for subnet
    cidr_block                = "10.0.2.0/24"   # Define CIDR-block for subnet
    map_public_ip_on_launch   = true            # Map public IP to deployed instances in this VPC
    vpc_id                    = aws_vpc.vpc.id  # Link Subnet to VPC
    tags = {
        Name                  = "Subnet-US-East-1a-Web" # Tag subnet with name
        Product               = var.product
        Team                  = var.team
        Owner                 = var.owner
        Environment           = var.environment
        Organization          = var.organization
        "Cost Center"         = var.costcenter
    }
}