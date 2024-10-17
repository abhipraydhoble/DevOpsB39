variable "vpc_cidr_block" {
    type = string
  
}


variable "aws_subnet" {
    type = list(string)
  
}

variable "az" {
    type = list(string)
  
}

variable "public_ip" {
  
  type = bool
}

variable "port_no" {
  type = list(number)
}
