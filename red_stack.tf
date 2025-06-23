data "aws_iam_policy_document" "redshift_iam_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["redshift.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "redshift_role" {
  name               = "redshift_cluster_role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.redshift_iam_policy.json
}

resource "aws_redshift_cluster" "chiz-red" {
  cluster_identifier = "tf-redshift-cluster"
  database_name      = "mydb"
  master_username    = "chiz-redshift"
  node_type          = "ra3.xlplus"
  cluster_type       = "multi-node"
  number_of_nodes     = 3
  manage_master_password = true
}

