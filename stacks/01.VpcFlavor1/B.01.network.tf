# trunk-ignore-begin(checkov/CKV_TF_1)
# Issue checkov/CKV_TF_1: Terraform modules should use a commit hash
# TODO: resolve the commit hashes

# trunk-ignore-begin(trivy/AVD-AWS-0178)
# Issue trivy/AVD-AWS-0178:  VPC Flow Logs is not enabled for VPC
# TODO: address this for real production environments

# Issue trivy/AVD-AWS-0104: Security group rule allows egress to multiple public internet addresses
# TODO: address this for real production environments
# trunk-ignore-begin(trivy/AVD-AWS-0104)

locals {
  tags = merge(var.tags, {
    "terraform.io"       = "managed",
    "terraform.io/stack" = "01.VpcFlavor1"
  })
}
module "vpc" {
  source = "cloudposse/vpc/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version = "2.2.0"

  namespace = "eg"
  stage     = "test"
  name      = "app"

  ipv4_primary_cidr_block = "10.0.0.0/16"

  assign_generated_ipv6_cidr_block = false

  tags = local.tags
}

module "dynamic_subnets" {
  source = "cloudposse/dynamic-subnets/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version            = "2.4.2"
  namespace          = "eg"
  stage              = "test"
  name               = "app"
  availability_zones = var.availability_zone_ids

  vpc_id = module.vpc.vpc_id
  igw_id = [module.vpc.igw_id]
  #cidr_block         = "10.0.0.0/16"
}

# trunk-ignore-end(trivy/AVD-AWS-0104)
# trunk-ignore-end(trivy/AVD-AWS-0178)
# trunk-ignore-end(checkov/CKV_TF_1)