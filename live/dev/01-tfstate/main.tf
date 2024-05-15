module "state" {
  source      = "../../../modules/tfstate"
  bucket_name = "${var.app_name}-${var.stage}-tfstate"
  table_name  = "${var.app_name}-${var.stage}-tfstate-locks"
}