
resource "ibm_schematics_action" "schematics_action" {
  name           = "test-ansible-action"
  resource_group = "Default"
  source {
    source_type = "github"
    git {
      git_repo_url = "https://github.com/hkantare/ansible-collection-ibm"
    }
  }
  command_parameter = "examples/vs-intel/vpc.yml"
  action_inputs {
    name  = "ibmcloud_resource_group_name"
    value = "Default"
  }
  action_inputs {
    name  = "ibmcloud_region"
    value = "br-sao"
  }
  action_inputs {
    name  = "ibmcloud_api_key"
    value = var.apikey
    metadata {
        secure = true
    }
  }
  action_inputs {
    name  = "ibmcloud_vpc_name"
    value = var.name
  }
}

resource "ibm_schematics_job" "schematics_job" {
  command_object    = "action"
  command_object_id = ibm_schematics_action.schematics_action.id
  command_name      = "ansible_playbook_run"
  command_parameter = "examples/vs-intel/vpc.yml"
}

provider "ibm" {
}

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}

variable "apikey" {

}

variable "name" {

}
