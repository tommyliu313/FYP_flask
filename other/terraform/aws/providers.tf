provider "aws"{
    version = "~> 2.0"
    alias = "networking"
    region = var.aws_region
    access_key = var.access_key
    secret_key = var.secret_key
}

provider "kubernetes"{
    host = data.aws_eks_cluster.cluster.endpoint
    version =
}