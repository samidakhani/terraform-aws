resource "aws_iam_user" "user" {
  name = var.users[count.index]
  tags = {
    description = "Terraform Tech Leader"
  }
  count = length(var.users)
}

resource "aws_iam_policy" "adminpolicy" {
  name   = "adminpolicy"
  policy = file("admin-policy.json")
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.user[count.index].name
  policy_arn = aws_iam_policy.adminpolicy.arn
  count      = length(aws_iam_user.user)
}