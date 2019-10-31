resource "aws_eks_cluster" "ekscluster" {
  name     = "${var.cluster_name}"
  role_arn = "${aws_iam_role.hackathon-cluster-iamrole.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.subnet-1.id}", "${aws_subnet.subnet-2.id}"]
  }
  depends_on = [
    "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSServicePolicy",
  ]
}

/**output "endpoint" {
  value = "${aws_eks_cluster.example.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.example.certificate_authority.0.data}"
}**/