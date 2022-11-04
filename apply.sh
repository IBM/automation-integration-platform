#!/usr/bin/env bash

if [[ -f "${PWD}/terragrunt.hcl" ]]; then
  terragrunt apply -auto-approve
else
  terraform init
  terraform apply -auto-approve
fi
