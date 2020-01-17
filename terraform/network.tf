# Terraform template to deploy fitapp in HA configuration and provision various resources.

resource "aws_vpc" "vpc" {
    cidr_block                = var.AWS_VPC_CIDR   # Defines overall VPC address space
    enable_dns_hostnames      = true                # Enable DNS hostnames for this VPC
    enable_dns_support        = true                # Enable DNS resolving support for this VPC
    tags = {
        Name                  = "VPC-${var.AWS_VPC_NAME}" # Tag VPC with name
        Product               = var.product
        Team                  = var.team
        Owner                 = var.owner
        Environment           = var.environment
        Organization          = var.organization
        "Cost Centre"         = var.costcentre
    }
}

resource "aws_subnet" "public-web-az-a" {
    availability_zone         = "us-east-1a"    # Define AZ for subnet
    cidr_block                = "10.0.1.0/24"   # Define CIDR-block for subnet
    map_public_ip_on_launch   = true            # Map public IP to deployed instances in this VPC
    vpc_id                    = aws_vpc.vpc.id  # Link Subnet to VPC
    tags = {
        Name                  = "Subnet-US-East-1a-Web-$(var.AWS_VPC_NAME)" # Tag subnet with name
        Product               = var.product
        Team                  = var.team
        Owner                 = var.owner
        Environment           = var.environment
        Organization          = var.organization
        "Cost Centre"         = var.costcentre
    }
}

resource "aws_subnet" "public-app-az-b" {
    availability_zone         = "us-east-1b"    # Define AZ for subnet
    cidr_block                = "10.0.2.0/24"   # Define CIDR-block for subnet
    map_public_ip_on_launch   = true            # Map public IP to deployed instances in this VPC
    vpc_id                    = aws_vpc.vpc.id  # Link Subnet to VPC
    tags = {
        Name                  = "Subnet-US-East-1b-App-$(var.AWS_VPC_NAME)" # Tag subnet with name
        Product               = var.product
        Team                  = var.team
        Owner                 = var.owner
        Environment           = var.environment
        Organization          = var.organization
        "Cost Centre"         = var.costcentre
    }
}

resource "aws_subnet" "private-rds-az-a" {
    # count                     = var.RDS_DATABASE
    availability_zone         = "us-east-1a"    # Define AZ for subnet
    cidr_block                = "10.0.3.0/24"   # Define CIDR-block for subnet
    map_public_ip_on_launch   = true            # Map public IP to deployed instances in this VPC
    vpc_id                    = aws_vpc.vpc.id  # Link Subnet to VPC
    tags = {
        Name                  = "Subnet-US-East-1a-Rds-$(var.AWS_VPC_NAME)" # Tag subnet with name
        Product               = var.product
        Team                  = var.team
        Owner                 = var.owner
        Environment           = var.environment
        Organization          = var.organization
        "Cost Centre"         = var.costcentre
    }
}

resource "aws_subnet" "private-rds-az-b" {
    # count                     = var.RDS_DATABASE
    availability_zone         = "us-east-1b"    # Define AZ for subnet
    cidr_block                = "10.0.4.0/24"   # Define CIDR-block for subnet
    map_public_ip_on_launch   = true            # Map public IP to deployed instances in this VPC
    vpc_id                    = aws_vpc.vpc.id  # Link Subnet to VPC
    tags = {
        Name                  = "Subnet-US-East-1b-Rds-$(var.AWS_VPC_NAME)" # Tag subnet with name
        Product               = var.product
        Team                  = var.team
        Owner                 = var.owner
        Environment           = var.environment
        Organization          = var.organization
        "Cost Centre"         = var.costcentre
    }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
    # count      = var.RDS_DATABASE
    name       = "rds-fitapp"
    subnet_ids = [aws_subnet.private-rds-az-a.id, aws_subnet.private-rds-az-b.id]

    tags = {
        Name          = "subnet_group-rds-${var.AWS_VPC_NAME}"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name          = "IG-${var.AWS_VPC_NAME}"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Center" = var.costcentre
    }
}

resource "aws_route_table" "rtb" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name          = "RTB-${var.AWS_VPC_NAME}"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

# Provide a resource to create a routing table entry (a route) in a VPC routing table.
resource "aws_route" "internet_access" {
    route_table_id         = aws_route_table.rtb.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.igw.id
}

# Provide a resource to create an association between a route table and a subnet or a route table and an internet gateway or virtual private gateway.
resource "aws_route_table_association" "public_subnet_association" {
    subnet_id      = aws_subnet.public-web-az-a.id
    route_table_id = aws_route_table.rtb.id
}

# Provide a security group resource.
resource "aws_security_group" "mgmt_sg" {
    name   = "mgmt_${var.AWS_VPC_NAME}"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 24224
        to_port     = 24224
        protocol    = "tcp"
        cidr_blocks = [var.AWS_VPC_CIDR]
    }

    ingress {
        from_port   = 2878
        to_port     = 2878
        protocol    = "tcp"
        cidr_blocks = [var.AWS_VPC_CIDR]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "web_sg" {
  name   = "web_${var.AWS_VPC_NAME}"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.AWS_VPC_CIDR]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  name   = "app_${var.AWS_VPC_NAME}"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.AWS_VPC_CIDR]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [var.AWS_VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "api_sg" {
  name   = "api_${var.AWS_VPC_NAME}"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.AWS_VPC_CIDR]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [var.AWS_VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name   = "db_${var.AWS_VPC_NAME}"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.AWS_VPC_CIDR]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.AWS_VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}