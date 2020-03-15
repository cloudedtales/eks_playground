variable "app_name" {
  default = "ScalableNginxExample"
}

variable "name" {
  default = "scalable-nginx-example"
}

variable "replicas" {
  default = 7
}

variable "image" {
  default = "nginx:1.7.8"
}

variable "hard_pod_limit" {
  default = 6
}

variable "cluster_name" {
  default = "terraform-eks-demo"
}