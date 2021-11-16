
variable "local_ip" {
  type = string
}


variable "images" {
  type = map

  default = {
    "us-west-2"      = "ami-09889d8d54f9e0a0e"
  }

  description = "AMI ID for the instance"
}

variable "region" {
  type    = string
}


variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The EC2 instance size"
}

variable "root_block_device_volume_size" {
  type        = string
  default     = "30"
  description = "The volume size for the root block device in GB"
}

variable "root_block_device_volume_type" {
  type        = string
  default     = "gp2"
  description = "The type of data storage: standard, gp2, gp3, io1"
}

variable "root_block_device_volume_delete_on_termination" {
  default     = true
  description = "Delete the root block device on instance termination."
}



variable "keypair_name" {
  type = string
}

variable "private_key" {
  type = string
}

variable "rstudio_password" {
  type = string
}

variable "postgres_version" {
  type = string
  default = "13.4"
}

variable "postgres_database" {
  type = string
}

variable "postgres_username" {
  type = string
}

variable "postgres_password" {
  type = string
}

