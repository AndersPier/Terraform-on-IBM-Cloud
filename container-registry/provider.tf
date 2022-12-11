variable "ibmcloud_api_key" {}
variable "region" {}
variable "ibm_id" {}

#
# ibmcloud_api_key, region and ibm_id declared in "terraform.tfvars" file - not committed in repo:
# Contents of "terraform.tfvars" file:
# ibmcloud_api_key = "API-KEY-GOES-HERE"
# region = "eu-de"
# ibm_id = "user@ibm.com" (user-id replaced with real email configured with IAM Manager policy, in IBM Cloud CLI)
#

provider "ibm" {
    ibmcloud_api_key = var.ibmcloud_api_key
    region = var.region
    }
    