# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# vim: et:ts=2:sw=2
# -----------------------------------------------------------------------------
variable "region" {
  description = "The AWS region."
}

variable "pathKeyPriv" {
  default = "~/.ssh/id_rsa"
}
variable "pathKeyPub" {
  default = "~/.ssh/id_rsa.pub"
}

variable "key_name" {
  description = "The AWS key pair to use for resources."
  default     = "thomas.pub"
}

variable "instAdminUser" {
  default = "admin"
}

variable "ami" {
  type        = "map"
  description = "A map of AMIs"
  default     = {}
}

variable "instance_type" {
  description = "The instance type to launch."
  default     = "t2.micro"
}

variable "instance_ips" {
  description = "The IPs to use for our instances"

  default = [
    "10.0.1.20",
    "10.0.1.21",
    "10.0.1.22",
    "10.0.1.23",
    "10.0.1.24",
  ]
}
