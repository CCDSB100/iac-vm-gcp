variable "squad_name" {
  type        = string
  description = "Identificador da squad ou nome da máquina"
  default     = "squad-default" //colocar nome da sua squad
}

variable "machine_type" {
  type        = string
  description = "Tipo de máquina do Compute Engine (ex: c4-standard-8, e2-medium)"
  default     = "c4-standard-8" //não troque o tipo da instância
}

variable "max_run_duration_seconds" {
  type        = number
  description = "Tempo máximo de execução da instância em segundos"
  default     = 3600 //tempo de execução da máquina até o auto delete (em segundos)
}
