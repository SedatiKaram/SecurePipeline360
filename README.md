# SecurePipeline360

A tiny Flask app that we'll use to build a free DevSecOps CI/CD pipeline with:
- GitHub Actions
- Trivy (container/dependency scanning)
- Checkov (IaC scanning)
- OWASP ZAP (DAST)

We'll enforce build-gating so merges fail on critical vulns.
