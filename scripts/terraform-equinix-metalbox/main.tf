terraform {
  required_version = ">= 0.13"
  required_providers {
    metal = {
      source = "equinix/metal"
      # version = "1.0.0"
    }
  }
}

# Configure the Equinix Metal Provider.
provider "metal" {
  auth_token = var.auth_token
}

data "metal_project" "project" {
  name = "Calico"
}

# Create a device and add it to tf_project_1
resource "metal_device" "k8s-main-node-1" {
  hostname         = "k8s-main-node-1"
  plan             = "c3.medium.x86"
  metro            = "da"
  operating_system = "ubuntu_20_04"
  billing_cycle    = "hourly"
  #project_id       = data.metal_project.project.id
  project_id       = "de6bc1c3-7500-4a0a-9725-4ca6140e1f24"
}
