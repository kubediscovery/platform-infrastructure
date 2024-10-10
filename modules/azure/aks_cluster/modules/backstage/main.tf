data "http" "send_data" {
  url          = var.url
  method       = "POST"
  request_body = jsonencode(var.filter)
  request_headers = {
    Accept        = "application/json"
    Authorization = "synera-br"
  }
}
