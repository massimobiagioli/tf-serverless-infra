module "state" {
  source      = "../../../modules/tfstate"
  bucket_name = "${var.service_name}-${var.stage}-tfstate"
  table_name  = "${var.service_name}-${var.stage}-tfstate-locks"
}