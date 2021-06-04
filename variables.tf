variable "encrypted" {
  type        = bool
  description = "If true, the file system will be encrypted."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "If set, use a specific KMS key. If using KMS 'encrypted' must be true."
  default     = null
}

variable "performance_mode" {
  type        = string
  description = "The file system performance mode. Can be either `generalPurpose` or `maxIO`."
  default     = "generalPurpose"
}

variable "provisioned_throughput_in_mibps" {
  default     = 0
  description = "The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with `throughput_mode` set to provisioned."
}

variable "throughput_mode" {
  type        = string
  description = "Throughput mode for the file system. Defaults to bursting. Valid values: `bursting`, `provisioned`. When using `provisioned`, also set `provisioned_throughput_in_mibps`."
  default     = "bursting"
}

variable "transition_to_ia" {
  type        = string
  description = "Indicates how long it takes to transition files to the IA storage class. Valid values: AFTER_7_DAYS, AFTER_14_DAYS, AFTER_30_DAYS, AFTER_60_DAYS and AFTER_90_DAYS."
  default     = ""
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Map of tags to assign to your resources."
}

variable "subnets" {
  description = "List of Subnets to add to the mount target."
  type = list(string)
}
variable "mount_target_ip_address" {
  type        = string
  description = "The address (within the address range of the specified subnet) at which the file system may be mounted via the mount target."
  default     = null
}

variable "vpc_id" {
  description = "The ID of the VPC you want to use"
  type = string
}

variable "ingress_with_source_security_group_id" {
  type = any
  description = "List of Mapped Ingress rules by SG ID"
  default = [{
    from_port                = 2049
    to_port                  = 2049
    protocol                 = "tcp"
    description              = "NFS"
    source_security_group_id = "sg-123456"
  }
  ]
}