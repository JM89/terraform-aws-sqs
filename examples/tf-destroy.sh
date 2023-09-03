#!/bin/sh

echo "Deploying $1 locally"

cd "examples/$1/"

echo "terraform plan -destroy -out plan"
terraform plan -destroy -out plan

echo "terraform apply plan"
terraform apply plan