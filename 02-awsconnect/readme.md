1. Install AWS CLI.
2. Execute the command (aws configure) to set the,
     a. Access key ID
     b. Secret access key
     These credentials will be stored in /home/<user>/.aws/credentials
3. Terraform will pick the acess key and secret from the location to connect to aws.
4. An alternate way to setup the acess key and secret is by setting the environment variable
     a. AWS_ACCESS_KEY_ID
     b. AWS_SECRET_ACCESS_KEY_ID
5. Region can also be set via command line parameter AWS_REGION.
6. Instead of configuring real credentials, can use a mocking framework with
provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  endpoints {
    iam                       = "http://aws:4566"
  }
}

   
    