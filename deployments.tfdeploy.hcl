# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "development" {
  inputs = {
    region         = "us-west-1"
    role_arn       = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token = identity_token.aws.jwt
    default_tags   = { stacks-preview-example = "lambda-api-gateway-stack" }
  }
}

deployment "production" {
  inputs = {
    region         = "us-east-1"
    role_arn       = "arn:aws:iam::225401527358:role/lambda-component-expansion-stack"
    identity_token = identity_token.aws.jwt
    default_tags   = { stacks-preview-example = "lambda-api-gateway-stack" }
  }
}
