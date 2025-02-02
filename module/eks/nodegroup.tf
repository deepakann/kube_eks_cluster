resource "aws_iam_role" "node-group-role" {
  name = "eks-nodegroup"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "global-eks-worker-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "global-eks-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "global-eks-container-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_eks_node_group" "instance-node-group" {
  cluster_name  = aws_eks_cluster.eksmaster.name
  node_group_name = "WorkerNG"
  node_role_arn = aws_iam_role.node-group-role.arn
  subnet_ids = [aws_subnet.pubsub01.id, aws_subnet.pubsub02.id]
  instance_types = ["t3.medium"]
  scaling_config {
    desired_size = 3
    max_size     = 5 
    min_size     = 3
  }
  labels = {
    zone = "east"
  }
  depends_on = [
    aws_iam_role_policy_attachment.global-eks-cni-policy,
    aws_iam_role_policy_attachment.global-eks-container-policy,
    aws_iam_role_policy_attachment.global-eks-worker-policy,
  ]
}
