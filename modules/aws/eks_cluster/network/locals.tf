locals {
  tags = merge({
    PartOf = "learn-aws"
  }, var.tags)
}