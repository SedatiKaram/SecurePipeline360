# SecurePipeline360

A demo **Cloud DevSecOps Pipeline** project built with **Flask (Python)**, **MySQL**, **Docker**, and **GitHub Actions**.  
Includes automated security scanning with **Trivy**, **Checkov**, and **OWASP ZAP**.

## Features
- CI/CD pipeline with GitHub Actions
- Containerized Flask app
- IaC scanning (Terraform, Kubernetes)
- Automated security gates
- Example of DevSecOps best practices

## Run locally
```bash
docker build -t securepipeline360 .
docker run -p 5000:5000 securepipeline360
```
Visit [http://localhost:5000](http://localhost:5000)
