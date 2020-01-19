# Use this data source to get information about an RDS instance
resource "aws_db_instance" "fitapp_rds_db" {
    count                  = var.RDS_DATABASE
    identifier             = var.RDS_IDENTIFIER
    depends_on             = [aws_security_group.db_sg]
    allocated_storage      = 20
    storage_type           = "gp2"
    engine                 = "mysql"
    engine_version         = "5.7.23"
    instance_class         = "db.t2.micro"
    name                   = "prospect"
    username               = "db_app_user"
    password               = "FitApp01!"
    multi_az               = var.MULTI_AZ_RDS
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.id
    parameter_group_name   = "default.mysql5.7"
    skip_final_snapshot    = true
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "rds-db-${var.AWS_VPC_NAME}"
        Tier          = "DB"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

# Use this data source to get the ID of an Amazon EC2 Instance for use in other resources.

resource "aws_instance" "db1" {
    ami                    = var.AMIS["db"]
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.private-rds-az-b.id
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    key_name               = aws_key_pair.dev_ssh_key.id
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "db1-${var.AWS_VPC_NAME}"
        Tier          = "DB"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

resource "aws_instance" "db2" {
    ami                    = var.AMIS["db"]
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.private-rds-az-b.id
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    key_name               = aws_key_pair.dev_ssh_key.id
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "db2-${var.AWS_VPC_NAME}"
        Tier          = "DB"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

resource "aws_instance" "dblb" {
    ami                    = var.AMIS["dblb"]
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.private-rds-az-b.id
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    key_name               = aws_key_pair.dev_ssh_key.id
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "dblb-${var.AWS_VPC_NAME}"
        Tier          = "DBLB"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

resource "aws_instance" "app1" {
    ami                    = var.AMIS["app"]
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.public-app-az-b.id
    vpc_security_group_ids = [aws_security_group.app_sg.id]
    key_name               = aws_key_pair.dev_ssh_key.id
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "app1-${var.AWS_VPC_NAME}"
        Tier          = "APP"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

resource "aws_instance" "app2" {
    ami                    = var.AMIS["app"]
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.public-app-az-b.id
    vpc_security_group_ids = [aws_security_group.app_sg.id]
    key_name               = aws_key_pair.dev_ssh_key.id
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "app2-${var.AWS_VPC_NAME}"
        Tier          = "APP"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

resource "aws_instance" "web1" {
    ami                         = var.AMIS["web"]
    instance_type               = "t2.medium"
    subnet_id                   = aws_subnet.public-web-az-a.id
    vpc_security_group_ids      = [aws_security_group.web_sg.id]
    key_name                    = aws_key_pair.dev_ssh_key.id
    associate_public_ip_address = true
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "web1-${var.AWS_VPC_NAME}"
        Tier          = "WEB"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

resource "aws_instance" "web2" {
    ami                         = var.AMIS["web"]
    instance_type               = "t2.medium"
    subnet_id                   = aws_subnet.public-web-az-a.id
    vpc_security_group_ids      = [aws_security_group.web_sg.id]
    key_name                    = aws_key_pair.dev_ssh_key.id
    associate_public_ip_address = true
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "web2-${var.AWS_VPC_NAME}"
        Tier          = "WEB"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

resource "aws_instance" "api1" {
    ami                    = var.AMIS["api"]
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.public-app-az-b.id
    vpc_security_group_ids = [aws_security_group.api_sg.id]
    key_name               = aws_key_pair.dev_ssh_key.id
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "api1-${var.AWS_VPC_NAME}"
        Tier          = "API"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
  }
}

resource "aws_instance" "api2" {
    ami                    = var.AMIS["api"]
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.public-app-az-b.id
    vpc_security_group_ids = [aws_security_group.api_sg.id]
    key_name               = aws_key_pair.dev_ssh_key.id
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "api2-${var.AWS_VPC_NAME}"
        Tier          = "API"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

resource "aws_instance" "mgmt" {
    ami                         = var.AMIS["mgmt"]
    instance_type               = "t2.micro"
    subnet_id                   = aws_subnet.public-web-az-a.id
    vpc_security_group_ids      = [aws_security_group.mgmt_sg.id]
    key_name                    = aws_key_pair.admin_ssh_key.id
    associate_public_ip_address = true
    tags = {
        App           = var.AWS_VPC_NAME
        Name          = "mgmt-${var.AWS_VPC_NAME}"
        Tier          = "MGMT"
        Product       = var.product
        Team          = var.team
        Owner         = var.owner
        Environment   = var.environment
        Organization  = var.organization
        "Cost Centre" = var.costcentre
    }
}

# Provides an AWS EBS Volume Attachment as a top level resource, to attach and detach volumes from AWS Instances.
resource "aws_ebs_volume" "ebs_volume_extra" {
    availability_zone   = "us-east-1a"
    size                = 10
    type                = "gp2"
    tags = {
        Name            = "Extra volume for data"
    }
}

resource "aws_volume_attachment" "ebs_att" {
    device_name         = "/dev/xvda"
    volume_id           = aws_ebs_volume.ebs_volume_extra.id 
    instance_id         = aws_instance.mgmt.id
}



