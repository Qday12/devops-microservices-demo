variable "vpc_id" {
  description = "ID istniejącego VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Lista subnetów w tym VPC"
  type        = list(string)
}
