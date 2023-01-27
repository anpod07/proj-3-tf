# - создаем VPC Subnet
#
# - data "aws_region" "<имя переменной>" {}	# получение данных с помощью Data Source
# - output "<название вывода>" {		# вывод данных на экран


# взять данные из ресурсов AWS
provider "aws" {}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones#attributes-reference
data "aws_availability_zones" "current_az" {}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "acc_profile" {}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region#attributes-reference
data "aws_region" "current" {}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc#argument-reference
data "aws_vpc" "my_custom_vpc" {
  tags = {
    Name = "ansible_VPC_RDS"
  }
}


output "data_current_az" {
  value = data.aws_availability_zones.current_az.names
}
output "data_acc_profile" {
  value = data.aws_caller_identity.acc_profile.account_id
}
output "data_region_name" {
  value = data.aws_region.current.name
}
output "data_region_descr" {
  value = data.aws_region.current.description
}
output "my_vpc_id" {
  value = data.aws_vpc.my_custom_vpc.id
}
output "my_vpc_cidr" {
  value = data.aws_vpc.my_custom_vpc.cidr_block
}
