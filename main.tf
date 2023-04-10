provider "aws" {
  region = var.region
}
provider "aws" {
  alias  = "west"
  region = var.region
}
/*
resource "aws_instance" "vm_not_managed" {
  # (resource arguments)
  ami           = "ami-06e46074ae430fba6"
  instance_type = var.instance_type
  tags = {
    Name = "VM_Not_Managed"
  }
}
*/

resource "aws_instance" "vdi" {
  ami           = "ami-06e46074ae430fba6"
  instance_type = var.instance_type

  tags = {
    Name = join("-",[module.main.name,"ROOT_MODULE"]) == "ROOT_MODULE" ? "OTRO" : join("-",[module.main.name,"ROOT_MODULE"])
  }
}

module "main" {
  source  = "./modules/app"
  instance_types = var.instance_type
}

output "name" {
  value     = "El output es del root module y este valor es del child module ${module.main.name} ya ves solo el root module imprime"
}
output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}
output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}
output "s3_data" {
  value       = data.terraform_remote_state.network
  description = "The S3 data Source"
}
output "s3_data_config" {
  value       = data.terraform_remote_state.network.config.bucket
  description = "The S3 data Source"
}
output "s3_data_config_outputs" {
  value       = data.terraform_remote_state.network.outputs
  description = "The S3 data Source"
}
output "s3_data_config_outputs_arn" {
  value       = data.terraform_remote_state.network.outputs.s3_bucket_arn
  description = "The S3 data Source"
}