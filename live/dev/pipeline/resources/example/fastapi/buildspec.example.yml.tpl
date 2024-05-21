version: 0.2

env:
  shell: bash

phases:
  install:
    runtime-versions:
      python: 3.11
  pre_build:
    commands:
      - echo "### Download parameters from SSM/ParameterStore (do escape directly on ssm)..."
      - aws ssm get-parameter --with-decryption --name /pipeline/${PIPELINE_NAME} --query Parameter.Value --output text > .env.${STAGE_NAME}.local     
      - cat .env.${STAGE_NAME}.local | sed -nr 's/(^.*=.*$)/declare -x \1/p' > .aws.ssm.local
      - source .aws.ssm.local
  build:
    commands:
      - echo "Launch tests..."
      - make test
  post_build:
    commands:
      - echo "Build completed on `date`"
