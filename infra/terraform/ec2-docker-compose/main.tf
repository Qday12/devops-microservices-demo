provider "aws" {
  region = "eu-north-1"  # zmień na swój region
}

# Security Group
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow HTTP + SSH traffic to backend"
  vpc_id      = "vpc-0637b2eb44d8228d3"
  # backend port
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance z userdata
resource "aws_instance" "backend" {
  ami           = "ami-0068163775a114e89"
  instance_type = "t3.micro"
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

user_data = <<-EOF
              #!/bin/bash
              # Update system
              apt-get update -y
              apt-get upgrade -y

              # Install Docker
              apt-get install -y docker.io docker-compose git

              # Enable Docker
              systemctl enable docker
              systemctl start docker

              # Add ubuntu user to docker group
              usermod -aG docker ubuntu

              # Clone repository
              git clone https://github.com/qday12/devops-microservices-demo.git /home/ubuntu/devops-microservices-demo
              chown -R ubuntu:ubuntu /home/ubuntu/devops-microservices-demo

              # Run backend
              cd /home/ubuntu/devops-microservices-demo
              sudo -u ubuntu docker-compose up -d
              EOF

  tags = {
    Name = "devops-backend"
  }
}
