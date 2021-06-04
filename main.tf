resource "aws_efs_file_system" "efs" {
  encrypted                       = var.encrypted
  kms_key_id                      = var.kms_key_id

  dynamic "lifecycle_policy" {
    for_each = var.transition_to_ia == "" ? [] : [1]
    content {
      transition_to_ia = var.transition_to_ia
    }
  }

  performance_mode                = var.performance_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  throughput_mode                 = var.throughput_mode

  tags = var.tags
}


resource "aws_efs_mount_target" "mount_target" {
  count = length(var.subnets) > 0 ? length(var.subnets) : 0

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = element(concat(var.subnets, [""]), count.index)

  ip_address      = var.mount_target_ip_address

  security_groups = [module.sg.security_group_id]

}

module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "v4.0.0"

  name        = "efs-sg-${aws_efs_file_system.efs.id}"
  vpc_id      = var.vpc_id
  description = "Security group for use with EFS."

  ingress_cidr_blocks      = [data.aws_vpc.vpc.cidr_block]
  ingress_rules            = ["nfs-tcp"]

  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id

  egress_rules = ["all-all"]

  tags = var.tags
}

