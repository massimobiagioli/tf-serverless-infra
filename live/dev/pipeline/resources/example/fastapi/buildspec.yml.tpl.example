version: 0.2

env:
  shell: bash

phases:
  install:
    runtime-versions:
      python: 3.12
    commands:
      - echo "### Installing Terraform..."
      - sudo yum install -y yum-utils shadow-utils
      - sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
      - sudo yum -y install terraform
      - echo "### Installing python-pip..."
      - sudo yum -y install python-pip
      - echo "### Installing Poetry dependencies..."
      - pip install poetry
  pre_build:
    commands:
      - echo "### Download parameters from SSM/ParameterStore (do escape directly on ssm)..."
      - aws ssm get-parameter --with-decryption --name /pipeline/${PIPELINE_NAME} --query Parameter.Value --output text > .env.${STAGE_NAME}.local     
      - cat .env.${STAGE_NAME}.local | sed -nr 's/(^.*=.*$)/declare -x \1/p' > .aws.ssm.local
      - source .aws.ssm.local
      - echo "### Terraform Init..."
      - make terraform-init stage=${STAGE_NAME} region=${AWS_REGION} 
  build:
    commands:      
      - echo "### Terraform Apply..."
      - make terraform-apply stage=${STAGE_NAME} region=${AWS_REGION}
  post_build:
    commands:
      - echo "Deploy completed on `date`"
