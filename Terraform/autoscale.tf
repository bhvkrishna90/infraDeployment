data "aws_region" "current" {}
locals {
  demo-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.ekscluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.ekscluster.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA
}

resource "aws_launch_configuration" "demo" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.hackathon-node.name}"
  image_id                    = "ami-0e238f8d607c4a5fd"
  instance_type               = "t2.micro"
  name_prefix                 = "hackathon-eks"
  security_groups             = ["${aws_security_group.node-sg.id}"]
  user_data_base64            = "${base64encode(local.demo-node-userdata)}"

  lifecycle {
      create_before_destroy = true
  }
}