#!/bin/sh

aws s3api create-bucket --bucket terraform-state --endpoint-url http://localstack:4566 --region eu-west-2 --create-bucket-configuration LocationConstraint=eu-west-2

# shellcheck disable=SC2164
cd "/etc/localstack/init/ready.d/terraform"

echo "Run fifo queue example"
sh tf-plan-apply.sh "fifo"

echo "Run standard queue example"
sh tf-plan-apply.sh "standard_with_dlq"