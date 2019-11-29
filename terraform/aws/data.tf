# Detect AZs available in var.primary_aws_region
data "aws_availability_zones" "available" {
  state = "available"
}
