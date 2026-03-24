variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
}

variable "ami" {
  description = "AMI ID for EC2"
}

variable "tags" {
  description = "Tags for EC2"
  type        = map(string)

  default = {
    Name = "Terraform-Ansible-Server"
  }
}