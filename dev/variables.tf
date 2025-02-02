variable "vpcname" {}
variable "clustersg" {}
variable "pubsub01" {}
variable "pubsub02" {}
variable "block1" {}
variable "block2" {}
variable "block3" {}
variable "block4" {}
variable "ekscluster" {
  default = "devcluster"
}
variable "env" {
  default = "dev"
}