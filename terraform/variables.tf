variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Ubunty 22.04 AMI ID"
  type        = string
  default     = "ami-0e86e20dae9224db8"
}

variable "key_name" {
  description = "Name of the existing AWS key pair"
  type        = string
  default     = "ansible-prject-key-pair"
}