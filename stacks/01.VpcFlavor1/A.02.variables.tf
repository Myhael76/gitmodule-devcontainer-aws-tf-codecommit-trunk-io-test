variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "availability_zone_ids" {
  type    = list(string)
  default = ["eu-central-1b", "eu-central-1c"]
}