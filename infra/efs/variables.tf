/*---------------SG variables---------------*/


variable "vpc_id" {
    type    = string
}

variable "private_subnet_id" {
    type    = list(string)
}
