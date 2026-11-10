variable "squad_name" {
  type        = string
  description = "Identificador da squad ou nome da máquina"
  default     = "squad-default" 
}

variable "machine_type" {
  type        = string
  description = "Tipo de máquina do Compute Engine (ex: c4-standard-8, e2-medium)"
  default     = "c4-standard-8"
}

variable "max_run_duration_seconds" {
  type        = number
  description = "Tempo máximo de execução da instância em segundos"
  default     = 3600
}

variable "region" {
  type        = string
  description = "Região do GCP"
  default     = "us-east1"
}

variable "zone" {
  type        = string
  description = "Zona do GCP"
  default     = "us-east1-b"
}