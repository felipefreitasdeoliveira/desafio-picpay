locals {
  eks = {
    cluster_name = "desafio-picpay-eks-dev"
    cluster_tags = {
      "environment" : "dev"
      "project" : "desafiopicpay"
    }
    cluster_labels = {
      "eksrole" : "general"
    }
  }
  vpc = {
    vpc_name = "desafiopicpay-dev"
  }

}
