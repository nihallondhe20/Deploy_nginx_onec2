resource "aws_security_group" "terraform-security-sg" {
  # ... other configuration ...

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name = aws_key_pair.tf_key.key_name
#  vpc_security_group_ids = [aws_security_group.terraform-security-sg.id]
  vpc_security_group_ids = ["sg-0f5ef8c06a975637c"]
  tags = {
    Name = "terra_secure"
  }
  connection {
    type     = "ssh"
    user     = "ubuntu"
   # password = var.root_password
    private_key = file("tf-test-key.pem")
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update ",
       "sudo apt install nginx",
       "sudo systemctl enable nginx",
       "sudo systemctl start nginx"
    ]
  }
  
  depends_on = [
   aws_key_pair.tf_key
  ]

}