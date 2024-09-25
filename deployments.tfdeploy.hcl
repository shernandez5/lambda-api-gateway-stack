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

orchestrate "auto_approve" "safe_plans_dev" {
  check {
    # Only auto-approve in development environment if no resources are being removed
    condition = context.plan.changes.remove == 0 && context.plan.deployment == deployment.development
    reason = "Plan has ${context.plan.changes.remove} resources to be removed."
  }
}
