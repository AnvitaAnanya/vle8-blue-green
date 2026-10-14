terraform {
  required_version = ">= 1.0"
}

resource "terraform_data" "vle8_lab" {
  input = {
    project    = "VLE-8"
    deployment = "blue-green"
    platform   = "minikube"
  }
}

output "project" {
  value = terraform_data.vle8_lab.output.project
}

output "deployment_strategy" {
  value = terraform_data.vle8_lab.output.deployment
}

output "platform" {
  value = terraform_data.vle8_lab.output.platform
}
