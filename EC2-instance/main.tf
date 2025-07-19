provider "aws" {
    region = "ap-south-1"
  
}

module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami_type =  "ami-06e753fac3cb1f27f"
    instance_type = "t3.micro"
  
}
