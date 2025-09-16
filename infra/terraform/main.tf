provider "aws" {
  region = "eu-central-1"  # zmień na swój region
}

# Security Group
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow HTTP traffic to backend"

  ingress {
    from_port   = 5000
    to_port     = 5000
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
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t3.micro"
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # Aktualizacja systemu
              yum update -y
              
              # Instalacja Dockera
              amazon-linux-extras enable docker
              yum install -y docker
              systemctl enable docker
              systemctl start docker
              usermod -aG docker ec2-user
              
              # Instalacja Docker Compose
              curl -L "https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose
              
              # Klonowanie repozytorium
              su - ec2-user -c "git clone https://github.com/qday12/devops-microservices-demo.git ~/devops-microservices-demo"
              
              # Uruchomienie backendu
              cd /home/ec2-user/devops-microservices-demo
              su - ec2-user -c "docker-compose up -d"
              EOF

  tags = {
    Name = "devops-backend"
  }
}
