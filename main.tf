resource "aws_instance" "nik1" {
  ami             = "ami-027d95b1c717e8c5d" 
  instance_type   = var.instance_type
  key_name        = var.instance_key
  vpc_security_group_ids = ["sg-050ea9ef27e04b9e0"]
  
    user_data = "${file("install_apache.sh")}"
  

  tags = {
    Name = "nik"
  }
}

resource "aws_security_group" "sg" {
    name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  
  ingress {
    description      = "Allow all SSH traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow all HTTP traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "Allow all HTTPS traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}