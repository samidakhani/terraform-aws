resource "aws_instance" "webserver" {
  ami = "ami-0b0af3577fe5e3532"
  instance_type = "t2.micro"
  tags = {
    Name = "webserver"
    Description = "An Nginx instance on webserver"
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    systemctl enable nginx
    systemctl start nginx
  EOF
  key_name = aws_key_pair.web_key.id
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
}

resource "aws_key_pair" "web_key" {
  public_key = file("C:\\Users\\sdakhani\\Desktop\\TERRAFORM\\keys\\aws_public_key.pub")
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh-access"
  description = "Allow SSH access from internet"
  ingress {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
}

output web_public_ip {
  value = aws_instance.webserver.public_ip
}