resource "tls_private_key" "tf_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tf_key" {
  key_name   = var.key_name       # Create a "myKey" to AWS!!
  public_key = tls_private_key.tf_key.public_key_openssh

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.tf_key.private_key_pem}' > ./myKey.pem"
  }
}