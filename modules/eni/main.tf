resource "aws_network_interface" "this" {
  subnet_id       = var.subnet_id
  security_groups = var.security_groups

  tags = {
    Name        = "blog-eni"
    Environment = "dev"
  }
  
}