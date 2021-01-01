#!/bin/bash

if [ -z "$AWS_ACCESS_KEY_ID" ]
then
  echo "To run this script, you'll need AWS credentials (for use with terraform plan)."
  exit 1
fi

# Generate all plan files
echo Generating plan files, where they do not exist yet
find . -name "main.tf" -exec dirname {} \; | grep -v ".terraform" | while read -r test_case; do echo $test_case ; ORG_PATH=$PWD ; cd $test_case ; if [ ! -f plan.out ]; then terraform init ; terraform plan -out=plan.out ; fi ; cd $ORG_PATH; done

# Checkov
echo Now running Checkov on all cases
docker pull bridgecrew/checkov:latest
find . -name "main.tf" -exec dirname {} \; | grep -v ".terraform" | while read -r test_case; do echo $test_case ; ORG_PATH=$PWD ; cd $test_case ; docker run -t -v $PWD:/tf bridgecrew/checkov --quiet -d /tf | sed 's/\[[0-9;]*m//g' > checkov_results.txt ; cd $ORG_PATH; done

# tfsec
echo Now running tfsec on all cases
docker pull liamg/tfsec:latest
find . -name "main.tf" -exec dirname {} \; | grep -v ".terraform" | while read -r test_case; do echo $test_case ; ORG_PATH=$PWD ; cd $test_case ; docker run --rm -v "$(pwd):/src" liamg/tfsec /src --no-color > tfsec_results.txt ; cd $ORG_PATH; done

# Cloudrail
echo Now running Cloudrail on all cases
docker pull indeni/cloudrail-cli:latest
find . -name "main.tf" -exec dirname {} \; | grep -v ".terraform" | while read -r test_case; do echo $test_case ; ORG_PATH=$PWD ; cd $test_case ; if [ ! -f cloudrail_results.txt ]; then docker run --rm -v $PWD:/data indeni/cloudrail-cli run --tf-plan /data/plan.out --directory /data --output-file cloudrail_results.txt ; fi ; cd $ORG_PATH; done
