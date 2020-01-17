variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AWS_VPC_NAME" {
}

variable "AWS_VPC_CIDR" {
  
}

variable "AMIS" {
  type = map(string)
  default = {
    web  = "ami-467ca739"
    mgmt = "ami-0ff8a91507f77f867"
    dblb = "ami-cfe4b2b0"
    db   = "ami-14c5486b"
    app  = "ami-467ca739"
    api  = "ami-467ca739"
  }
}

variable "AWS_ADMIN_SSH_KEY_NAME" {
}

variable "AWS_ADMIN_PUBLIC_SSH_KEY" {
}

variable "AWS_DEV_SSH_KEY_NAME" {
}

variable "AWS_DEV_PUBLIC_SSH_KEY" {
}

variable "PATH_TO_ADMIN_PRIVATE_KEY" {
}

variable "PATH_TO_DEV_PRIVATE_KEY" {
}

variable "INSTANCE_USERNAME" {
}
variable "RDS_DATABASE" {
}

variable "RDS_IDENTIFIER" {
}

variable "MULTI_AZ_RDS" {
}

variable "product" {
}

variable "team" {
}

variable "owner" {
}

variable "environment" {
}

variable "organization" {
}

variable "costcentre" {
}