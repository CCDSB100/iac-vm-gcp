# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "teste-squad4" {
  boot_disk {
    device_name = "teste-squad4"
  }
  confidential_instance_config {
    enable_confidential_compute = false
  }
  description = ""
  instance_encryption_key {
  }
  key_revocation_action_type = "NONE"
  machine_type               = "c4-standard-8"
  metadata_startup_script    = "#!/bin/bash\nset -e\n\nif ! command -v docker >/dev/null 2>&1; then\n  curl -fsSL https://get.docker.com | sh\nfi\n\nsystemctl enable --now docker"
  name                       = "teste-squad4"
  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }
    stack_type         = "IPV4_ONLY"
    subnetwork         = "projects/project-5548564d-93e9-4f06-939/regions/us-east1/subnetworks/default"
    subnetwork_project = "project-5548564d-93e9-4f06-939"
  }
  reservation_affinity {
    type = "ANY_RESERVATION"
  }
  scheduling {
    automatic_restart           = false
    instance_termination_action = "DELETE"
    max_run_duration {
      seconds = 3600
    }
    on_host_maintenance = "TERMINATE"
    provisioning_model  = "STANDARD"
  }
  service_account {
    email  = "309462774956-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }
  tags = ["http-server", "https-server"]
  zone = "us-east1-b"
}

module "ops_agent_policy" {
  source          = "github.com/terraform-google-modules/terraform-google-cloud-operations/modules/ops-agent-policy"
  project         = "project-5548564d-93e9-4f06-939"
  zone            = "us-east1-b"
  assignment_id   = "goog-ops-agent-v2-template-1-7-0-us-east1-b"
  agents_rule = {
    package_state = "installed"
    version = "latest"
  }
  instance_filter = {
    all = false
    inclusion_labels = [{
      labels = {
        goog-ops-agent-policy = "v2-template-1-7-0"
      }
    }]
  }
}
