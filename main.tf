terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

provider "google" {
  project = "project-5548564d-93e9-4f06-939"
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "teste-squad" {
  name         = "teste-${var.squad_name}"
  machine_type = var.machine_type
  zone         = var.zone
  description  = "Ambiente de testes automatizado para a squad ${var.squad_name}"

  boot_disk {
    device_name = "teste-${var.squad_name}"
    auto_delete = true
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
      size  = 100
      type  = "hyperdisk-balanced"
    }
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  # Script de inicialização: Instala Docker E o Google Cloud Ops Agent nativamente
  metadata_startup_script = <<-EOT
    #!/bin/bash
    set -e

    echo "=== Atualizando sistema e instalando Docker ==="
    if ! command -v docker >/dev/null 2>&1; then
      curl -fsSL https://get.docker.com | sh
    fi
    systemctl enable --now docker

    echo "=== Instalando Google Cloud Ops Agent ==="
    curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
    sudo bash add-google-cloud-ops-agent-repo.sh --also-install
    sudo systemctl status google-cloud-ops-agent || true
  EOT

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }
    stack_type         = "IPV4_ONLY"
    subnetwork         = "projects/project-5548564d-93e9-4f06-939/regions/${var.region}/subnetworks/default"
    subnetwork_project = "project-5548564d-93e9-4f06-939"
  }

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
    provisioning_model  = "STANDARD"

    max_run_duration {
      nanos   = 0
      seconds = var.max_run_duration_seconds
    }
    instance_termination_action = "DELETE"
  }

  service_account {
    email  = "309462774956-compute@developer.gserviceaccount.com"
    scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }

  tags = ["http-server", "https-server"]
}