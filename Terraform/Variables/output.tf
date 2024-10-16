output "public_ip" {
  
  value = aws_instance.vm-nginx.public_ip
}
