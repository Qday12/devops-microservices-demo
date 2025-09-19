output "instance_ip" {
  description = "Public IP of the backend EC2"
  value       = aws_instance.backend.public_ip
}