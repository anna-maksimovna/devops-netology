provider "aws" {
   region = "eu-north-1"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-00514a528eadbc95b"
  instance_type          = "t3.micro"
}