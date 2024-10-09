
variable "url" {
  type        = string
  default     = "https://platform-catalog.synera.com.br/api/backstage"
  description = "Url to send cloud provider"
}

variable "filter" {
  type = object({
    provider = string
    account  = string
  })
  default = {
    provider = "none"
    account  = ""
  }
}
