#!/bin/bash

set -e

/usr/local/bin/terraform plan -var-file "../variables/ecs_webservers.tfvars" -out "ecs_demo_plan.tfplan"
