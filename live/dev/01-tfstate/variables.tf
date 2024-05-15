variable "service_name" {
  type        = string
  description = "Name of the service"
}

variable "stage" {
  type        = string
  description = "Stage of the service (dev, staging, prod)"
}

variable "aws_params" {
  type        = map(string)
  description = "AWS parameters"

  default = {
    region  = "eu-west-1"
    profile = "default"
  }
}
