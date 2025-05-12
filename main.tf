terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ca-central-1"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "bootstrap.zip"
  function_name = "hello-world"
  description   = "my first go lambda function using terraform"
  handler       = "local.binary_name"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "go1.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
