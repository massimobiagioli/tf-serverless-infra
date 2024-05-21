app_name = "tester"
stage    = "dev"

aws_params = {
  region  = "eu-west-1"
  profile = "personal_admin"
}

github_repository = {
  name   = "massimobiagioli/fastapi-sls-tester"
  branch = "main"
}

build_template  = "./resources/buildspec.yml"
deploy_template = "./resources/deployspec.yml"

tags = {
  Owner   = "Massimo Biagioli"
  Destroy = "false"
}