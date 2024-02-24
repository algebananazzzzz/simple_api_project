locals {
  execution_role_name = "${var.env}-mgmt-iamrole-${var.project_name}"
  function_name       = "${var.env}-app-func-${var.project_name}"
}


module "function_execution_role" {
  source = "./modules/iam_role"
  name   = local.execution_role_name
}

module "lambda_function" {
  source             = "./modules/lambda_function"
  function_name      = local.function_name
  execution_role_arn = module.function_execution_role.role.arn
  deployment_package = {
    filename         = data.archive_file.deployment_package.output_path
    source_code_hash = data.archive_file.deployment_package.output_base64sha256
  }
  runtime = "provided.al2"
  handler = "bootstrap"
}

data "archive_file" "deployment_package" {
  type        = "zip"
  source_dir  = "${path.module}/${var.deployment_package_location}"
  output_path = "${path.module}/../deploy/${var.project_name}.zip"
}
