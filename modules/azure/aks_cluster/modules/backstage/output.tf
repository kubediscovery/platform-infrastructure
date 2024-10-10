
output "status_response" {
  value       = data.http.send_data.status_code
  description = "The JSON representation of the Backstage Entity"
}