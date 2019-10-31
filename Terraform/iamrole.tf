resource "aws_iam_role" "hackathon-cluster-iamrole" {
  name = "${var.cluster_iamrole_Name}"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "Hackathon-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.hackathon-cluster-iamrole.name}"
}

resource "aws_iam_role_policy_attachment" "Hackathon-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.hackathon-cluster-iamrole.name}"
}

resource "aws_iam_role" "hackathon-node" {
  name = "${var.node_iamrole_Name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "hackathon-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.hackathon-node.name}"
}

resource "aws_iam_role_policy_attachment" "hackathon-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.hackathon-node.name}"
}

resource "aws_iam_role_policy_attachment" "hackathon-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.hackathon-node.name}"
}

resource "aws_iam_instance_profile" "hackathon-node" {
  name = "${var.node_iamrole_profile}"
  role = "${aws_iam_role.hackathon-node.name}"
}