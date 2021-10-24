resource "aws_dynamodb_table" "cars" {
  name           = "cars"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "VIN"
  attribute {
    name = "VIN"
    type = "S"
  }
}
