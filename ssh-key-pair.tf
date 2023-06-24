resource "tls_private_key" "tf_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tf_key" {
  key_name   = tf-test-key       
  public_key = tls_private_key.tf_key.public_key_openssh

  provisioner "local-exec" { 
    command = "echo '${tls_private_key.tf_key.private_key_pem}' > ./tf-test-key"
  }
}