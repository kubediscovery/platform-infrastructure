
# resource "aws_s3_bucket" "this" {
#   bucket = "kubediscovery"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#     PartOf      = "Platform"
#     ManagedBy   = "Terraform"
#   }
# }



# resource "aws_s3_object" "this" {
#   bucket       = "kubediscovery"
#   key          = "platform/terraform/infrastructure"
#   content_type = "application/x-directory"
# }
