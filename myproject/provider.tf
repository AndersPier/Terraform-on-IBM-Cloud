variable "ibmcloud_api_key" {}
variable "region" {}

#
# ibmcloud_api_key and region declared in "terraform.tfvars" file - not committed in repo:
# Contents of "terraform.tfvars" file:
# ibmcloud_api_key = "API-KEY-GOES-HERE"
# region = "eu-de"
#

provider "ibm" {
    ibmcloud_api_key = var.ibmcloud_api_key
    region = var.region
    }