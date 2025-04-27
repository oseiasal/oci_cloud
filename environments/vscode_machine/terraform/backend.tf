terraform {
  backend "s3" {
    bucket         = "my-terraform-state-saving"
    key            = "oci_cloud/terraform/vscode_machine/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}