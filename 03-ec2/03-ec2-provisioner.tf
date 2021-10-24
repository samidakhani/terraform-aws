resource "aws_instance" "dbserver" {
  ami = "ami-0b0af3577fe5e3532"
  instance_type = "t2.micro"
  tags = {
    Name = "dbserver"
    Description = "An Nginx instance on webserver"
  }
  provisioner "remote-exec" {
    inline = ["sudo apt update",
    "sudo apt install nginx -y",
    "systemctl enable nginx",
    "systemctl start nginx"]
    connection {
      type = "ssh"
      host = self.public_ip
      user = "root"
      private_key = file("C:\\Users\\sdakhani\\Desktop\\TERRAFORM\\keys\\aws_private_key")
    }
  }
  provisioner "local-exec" {
    on_failure = continue
    when = create
    command = "echo ${aws_instance.dbserver.public_ip}"
  }
  key_name = aws_key_pair.db_key.id
  vpc_security_group_ids = [aws_security_group.db_ssh_access.id]
}

resource "aws_key_pair" "db_key" {
  public_key = file("C:\\Users\\sdakhani\\Desktop\\TERRAFORM\\keys\\aws_public_key.pub")
}

resource "aws_security_group" "db_ssh_access" {
  name        = "db-ssh-access"
  description = "Allow SSH access from internet"
  ingress {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
}

output db_public_ip {
  value = aws_instance.dbserver.public_ip
}