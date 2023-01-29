# https://godfreym.medium.com/terraform-devops-using-jenkins-part2-terraform-remote-state-and-jenkins-pipeline-5187df5c544f
terraform {
  backend "s3" {
    bucket = "anpod07-tf-statefile"
    key    = "test/terraform.tfstate"
    region = "eu-central-1"
    encrypt=true
  }
}

