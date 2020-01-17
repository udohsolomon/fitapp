# Provide AWS Access key and Secret Key

provider "aws" {
  access_key      = var.AWS_ACCESS_KEY
  secret_key      = var.AWS_SECRET_KEY
  region          = var.AWS_REGION
}

resource "aws_key_pair" "admin_ssh_key" {
  key_name   = var.AWS_ADMIN_SSH_KEY_NAME
  public_key = file(var.AWS_ADMIN_PUBLIC_SSH_KEY)
}

resource "aws_key_pair" "dev_ssh_key" {
  key_name   = var.AWS_DEV_SSH_KEY_NAME
  public_key = file(var.AWS_DEV_PUBLIC_SSH_KEY)
}
# resource "tls_private_key" "privatekey" {
#   algorithm               = "RSA" 
#   rsa_bits                = 4096
# }

# This allows terraform to backup the *.tfstate file to AWS s3 bucket. Uncomment or Remove the lines to disable remote backup and use local state (Not Recommended)
# terraform {
#   backend "s3" {
#     bucket = "mybucket"
#     key    = "path/to/my/key/some.tfstate"
#     region = "us-east-1"
#   }
# }
# Here it is initialized with empty parameters. Other params can be passed at "terraform init --backend-config="bucket=mybucket" --backend-config="key=path/to/my/key/some.tfstate" --backend-config="region=us-east-1""

# terraform {
#   backend "s3" {
#   }
# }

# resource "aws_key_pair" "keypair" {
#     key_name                = var.AWS_ADMIN_SSH_KEY_NAME
#     public_key              = tls_private_key.privatekey.public_key_openssh
# }

# output "private_key" {
#   value                     = tls_private_key.privatekey.private_key_pem
#   sensitive                 = true
# }