### 🚀 DevOps Microservices Demo

## 📌 Project Overview
This project demonstrates a complete **DevOps / Cloud Native workflow** using modern tools and best practices.  
It covers the entire lifecycle: from coding, testing, and security scanning to containerization, cloud infrastructure provisioning, deployment, and monitoring.  

The backend is a simple **Flask API** with endpoints for health checks, users, and metrics — but the main purpose is to showcase **DevOps automation**.

---

## 🛠️ Tech Stack
- **Python + Flask** – backend API  
- **Docker** – containerization  
- **Terraform** – Infrastructure as Code (AWS EKS, VPC, nodes)  
- **Kubernetes (EKS)** – orchestration and deployments  
- **GitHub Actions** – CI/CD pipeline  
- **Prometheus + Grafana** – monitoring and observability  
- **Trivy** – security and dependency scanning  

---

## ⚙️ Workflow

1. **Code Push → GitHub Actions runs**:
   - ✅ Unit tests with `pytest`  
   - 🔒 Security scans (Trivy)  
   - 🛠️ Build and push Docker images  
   - ☁️ Deploy to AWS EKS  

2. **Terraform** provisions the infrastructure:  
   - VPC, EKS cluster, node groups  

3. **Kubernetes** manages deployments and services.  
4. **Prometheus + Grafana** provide observability with metrics and dashboards.  

---

## 📦 Local Setup

# Clone repository
git clone https://github.com/USERNAME/REPO.git
cd REPO/app/backend

# Install dependencies
pip install -r requirements.txt

# Run locally
python app.py

---

## ☸️ Deployment

# Terraform (infrastructure)
cd terraform
terraform init
terraform apply

# Kubernetes (application + services)
kubectl apply -f k8s/aws/backend.yaml

# Monitoring
kubectl apply -f k8s/aws/monitoring.yaml

---

## 📊 Monitoring

# Prometheus
kubectl port-forward svc/prometheus -n monitoring 9090:9090
Access at: http://localhost:9090

# Grafana
kubectl port-forward svc/grafana -n monitoring 3000:3000
Access at: http://localhost:3000
    Default login: admin / admin
    Add Prometheus as a data source

---

## 🔒 Security
Trivy scans Docker images for vulnerabilities during CI/CD.

---

## 🚀 CI/CD with GitHub Actions
On Pull Request and Merge to Main: run tests, and security scans, build Docker image, push to registry and deploy to AWS EKS.

---

## Author
Created by Paweł (github.com/qday12)
Purpose: showcase DevOps, IaC, CI/CD, Kubernetes, and observability skills.