variable "rgname" {
  description = "resource grouop name"
  default     = "Assignment"
}
variable "location" {
  description = "location name"
  default     = "East Us"
}
variable "vnet_name" {
  description = "name for vnet"
  default     = "assignment_vnet"
}
variable "address_space" {
  default     = ["10.0.0.0/16"]
}
variable "subnet_name" {
  default     = "public_subnet"
}
variable "address_prefix" {
  default     = "10.0.1.0/24"
}

variable "external_ip" {
  type        = list(string)
  default      = ["0.0.0.0"]
}
variable "numbercount" {
  type 	  = number
  default       = 2
}

variable "public_key" {
  type = string
  default = "ssh-rsa xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
