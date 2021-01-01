#!/bin/sh

if [ -z "$AWS_ACCESS_KEY_ID" ]
then
  echo "To run this script, you'll need AWS credentials (for use with terraform plan)."
  exit 1
fi

# Checkov
echo Now running Checkov on all cases
pip3 install -U checkov
find . -name "main.tf" -exec dirname {} \; | grep -v ".terraform" | while read -r test_case; do echo $test_case ; ORG_PATH=$PWD ; cd $test_case ; checkov -d . | tee checkov_results.txt ; cd $ORG_PATH; done

# tfsec
echo Now running tfsec on all cases
brew install tfsec
brew upgrade tfsec
find . -name "main.tf" -exec dirname {} \; | grep -v ".terraform" | while read -r test_case; do echo $test_case ; ORG_PATH=$PWD ; cd $test_case ; tfsec --no-color | tee tfsec_results.txt ; cd $ORG_PATH; done

# Cloudrail
echo Now running Cloudrail on all cases
pip3 install cloudrail --upgrade --extra-index-url https://indeni.jfrog.io/indeni/api/pypi/cloudrail-cli-pypi/simple
find . -name "main.tf" -exec dirname {} \; | grep -v ".terraform" | while read -r test_case; do echo $test_case ; ORG_PATH=$PWD ; cd $test_case ; if [ ! -f cloudrail_results.txt ]; then terraform init ; terraform plan -out=plan.out ; cloudrail run --tf-plan plan.out --directory . --output-file cloudrail_results.txt ; fi ; cd $ORG_PATH; done
