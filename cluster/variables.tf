variable "cluster-name" {
  default = "terraform-eks-demo"
  type = string
}

variable "kubernetes_version" {
  default = "1.15"
}

variable "nodes_desired_size" {
  default = 2
}

variable "nodes_max_size" {
  default = 2
}

variable "nodes_min_size" {
  default = 2
}

variable "log_retention_in_days" {
  default = 7
}