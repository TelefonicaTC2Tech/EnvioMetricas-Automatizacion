# EnvioMetricas's Telemetry 
# ====================================== #
#
# This file contains the Telemetry resources created to collect execution data.
# This file is self-contained: all the variables' declarations and dependencies are included (ex, 
# variable real values, for obvious security reasons).
#

# Telemetry Variables
# -------------------------------------- #
#
# Declaration of Vars required by the Telemetry collection.

variable "telemetry_token" {
  type        = string
  description = "Telemetry Authentication Token"
  default     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx"
}

variable "telemetry_workflow" {
  type        = string
  description = "Telemetry Terraform Workflow"
  default     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx"
}

variable "telemetry_country" {
  type        = string
  description = "Telemetry Country ID. Two-letter ISO code"
  default     = "ES"
}

# Telemetry-Tracking Resource Blocks
# -------------------------------------- #
#
# Telemetry in TF is implemented through a 'terraform_data' block which is triggered upon any
# `terraform apply` command, whether there is creation, edition or destruction of resources.
# Telemetry relies on a shell-based script that handles the connection, such as any Proxy 
# configuration from the system.

resource "terraform_data" "telemetry" {
  triggers_replace = {
    always_run = timestamp() # Always run the script upon any `terraform apply` command
  }

  provisioner "local-exec" {
    working_dir = "./" # Relative path to the working directory of the script
    command     = "chmod u+x send-telemetry.sh; ./send-telemetry.sh" # ensure the script is executable and run it

    environment = {
      TL_TOKEN    = var.telemetry_token
      TL_WORKFLOW = var.telemetry_workflow
      TL_COUNTRY  = var.telemetry_country
    }
  }
}
