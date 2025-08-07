remote_state {
  backend = "s3"
  config = {
    bucket  = "terraform-state-desafiopicpay-dev"
    key     = "aws/desafiopicpay-dev/us-east-1/dev/iac/terraform/${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
