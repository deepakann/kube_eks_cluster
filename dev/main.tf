module "eksclustercreate" {
  source = "../module/eks"
  block1 = var.block1
  block2 = var.block2
  block3 = var.block3
  block4 = var.block4
  pubsub01 = var.pubsub01
  pubsub02 = var.pubsub02
  vpcname = var.vpcname
  clustersg =  var.clustersg
  ekscluster = var.ekscluster
  env = var.env
}