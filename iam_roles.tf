data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "AWS_IAM_ROLE_EC2" {
  name               = var.AWS_IAM_ROLE_EC2_NAME
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
  #   assume_role_policy = aws_iam_policy.AWS_IAM_POLICY_EC2_CUSTOMIZED.policy
  managed_policy_arns = [aws_iam_policy.AWS_IAM_POLICY_EC2_CUSTOMIZED.arn]
}


resource "aws_iam_instance_profile" "AWS_IAM_ROLE_EC2_PROFILE" {
  name = var.AWS_IAM_ROLE_EC2_NAME
  role = aws_iam_role.AWS_IAM_ROLE_EC2.name
}
