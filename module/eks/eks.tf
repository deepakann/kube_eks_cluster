resource "aws_eks_cluster" "eksmaster" {
  name     = var.ekscluster
  role_arn = aws_iam_role.master.arn
  version = "1.31"

  vpc_config {
    subnet_ids = [aws_subnet.pubsub01.id, aws_subnet.pubsub02.id]
  }
  depends_on = [
    aws_iam_role.master
    aws_iam_role.master
  ]
  tags = {
    Name = "clustertype"
    Environment = var.env
  }
}
