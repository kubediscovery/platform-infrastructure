variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}

variable "project_name" {
  type    = string
  default = "learn"
}