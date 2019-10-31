resource "aws_eks_cluster" "ekscluster" {
  name     = "${var.cluster_name}"
  role_arn = "${aws_iam_role.hackathon-cluster-iamrole.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.subnet-1.id}", "${aws_subnet.subnet-2.id}"]
  }
  depends_on = [
    "aws_iam_role_policy_attachment.Hackathon-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.Hackathon-cluster-AmazonEKSServicePolicy",
  ]
}

locals {
  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.ekscluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.ekscluster.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}"
KUBECONFIG
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}

output "endpoint" {
  value = "${aws_eks_cluster.ekscluster.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.ekscluster.certificate_authority.0.data}"
}