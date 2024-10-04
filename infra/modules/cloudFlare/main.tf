
data "cloudflare_dns_record" "example" {
  zone_id  = "0da42c8d2132a9ddaf714f9e7c920711"
  hostname = "example.com"
}
resource "cloudflare_dns_record" "example" {
  zone_id = data.cloudflare_dns_record.example.zones.id
  name    = "www"
  value   = "203.0.113.1"
  type    = "A"
  proxied = true
}

# resource "cloudflare_dns_record" "example" {
#   zone_id = data.cloudflare_zone.example.id
#   name    = "www"
#   value   = "203.0.113.1"
#   type    = "A"
#   proxied = true
# }

