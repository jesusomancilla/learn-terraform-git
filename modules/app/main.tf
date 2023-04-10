provider "aws" {
  region = var.region
}

variable "instance_types" {
  type = string
}

resource "aws_instance" "vdi" {
  ami           = "ami-06e46074ae430fba6"
  instance_type = var.instance_types

  tags = {
    Name = "FROM_CHILD_VDI"
  }
}

output "name" {
  value     =  aws_instance.vdi.tags["Name"]
}