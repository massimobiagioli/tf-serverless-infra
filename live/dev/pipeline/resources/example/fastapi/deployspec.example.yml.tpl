version: 0.2

env:
  shell: bash

phases:
  install:
    runtime-versions:
      nodejs: 18.x
    commands:
      - echo "Installing Serverless..."
      - npm install -g serverless@3.38.0
      - npm ci
      - sudo yum -y install python-pip
      - pip install poetry
  pre_build:
    commands:
      - echo "### Download parameters from SSM/ParameterStore (do escape directly on ssm)..."
      - aws ssm get-parameter --with-decryption --name /pipeline/${PIPELINE_NAME} --query Parameter.Value --output text > .env.${STAGE_NAME}.local     
      - cat .env.${STAGE_NAME}.local | sed -nr 's/(^.*=.*$)/declare -x \1/p' > .aws.ssm.local
      - source .aws.ssm.local      
  build:
    commands:      
      - echo "Deploying to AWS - Stage $STAGE_NAME..."
      - serverless deploy --stage $STAGE_NAME --verbose --force -r ${AWS_REGION}
  post_build:
    commands:
      - echo "Deploy completed on `date`"
