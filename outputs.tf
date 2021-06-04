output "efs_sg" {
  value = module.sg.security_group_id
  description = "ID of the SG assigned to EFS Mount Point."
}

output "efs_arn" {
  value       = aws_efs_file_system.efs.arn
  description = "ARN of the EFS instance."
}

output "id" {
  value       = aws_efs_file_system.efs.id
  description = "ID of the EFS instance."
}

output "dns_name" {
  value       = concat(aws_efs_mount_target.mount_target.*.dns_name, [""])
  description = "Domain Name of the EFS moint point."
}

output "mount_target_ids" {
  value       = coalescelist(aws_efs_mount_target.mount_target.*.id, [""])
  description = "List of EFS mount target IDs."
}