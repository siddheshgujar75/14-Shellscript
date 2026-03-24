region        = "ap-south-1"
instance_type = "t2.micro"
key_name      = "terraform-key"
ami           = "ami-0f559c3642608c138"
tags = {
  Name = "Terraform-Ansible-Server"
}