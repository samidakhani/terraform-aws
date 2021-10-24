resource "aws_s3_bucket" "finance2021" {
  bucket = "finance-2021"
  tags = {
    Name = "Finanace 2021"
  }
}

resource "aws_s3_bucket_object" "finance-payroll" {
  bucket  = aws_s3_bucket.finance2021.id
  key     = "finance-payroll.docx"
  content = "C:\\Users\\sdakhani\\Desktop\\TERRAFORM\\finance-payroll.docx"
}

data "aws_iam_group" "finance-analyst" {
  group_name = "finance-analyst"
}

resource "aws_s3_bucket_policy" "finance-policy" {
  count = 0
  bucket = aws_s3_bucket.finance2021.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
          {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.finance2021.id}/*",
            "Principal": {
            "AWS": [
                "${data.aws_iam_group.finance-analyst.arn}"
                ]
            }
          }
        ]
  }
EOF
}