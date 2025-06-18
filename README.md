
# 🌥️ Cloud-Native GCP Deployment

This repository provides a modular and reusable setup for deploying infrastructure and containerized applications on **Google Cloud Platform (GCP)** using **Terraform** and **Kubernetes (GKE)**. 

> 🔧 CI/CD integration will be added in the future (Testing is complete, code factoring is in progress). This README currently covers infrastructure provisioning and Kubernetes deployment.

---

## 🚀 Overview

- Infrastructure as Code using **Terraform**
  - VPC, GKE cluster, IAM, Artifact Registry, etc.
- Kubernetes deployment setup using **kubectl**
- Environment-specific configurations (dev, staging, prod)
- Scripts for bootstrap/init tasks

---

## 📁 Repository Structure

```
cloud-native-gcp-deployment/
├── terraform/
│   ├── modules/             # Reusable Terraform modules (network, GKE, IAM)
│   ├── dev/                 # Dev environment configurations
│   ├── staging/
│   └── prod/
├── kubernetes/
│   ├── base/                # Shared k8s resources (ConfigMaps, Secrets)
│   └── overlays/            # Environment-specific deployment configs
│       ├── dev/
│       ├── pre-prod/
│       └── prod/
├── scripts/
│   └── bootstrap.sh         # Optional helper script for provisioning
└── README.md
```

---

## ⚙️ Prerequisites

Before using this project, ensure you have:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.3
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk)
- Docker (optional, if building container images locally)
- A GCP project with required APIs enabled:
  - `compute.googleapis.com`
  - `container.googleapis.com`
  - `artifactregistry.googleapis.com`

---

## 🔧 Setup Instructions

### 1. Configure Google Cloud

```bash
gcloud auth login
gcloud config set project <YOUR_PROJECT_ID>
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-c
```

### 2. Deploy Infrastructure with Terraform

```bash
cd terraform/dev
terraform init
terraform plan
terraform apply
```

This creates:
- VPC + subnet
- GKE cluster
- IAM roles & service accounts
- Artifact Registry (optional)

### 3. Get GKE Cluster Credentials

```bash
gcloud container clusters get-credentials <CLUSTER_NAME> --zone us-central1-c
```

### 4. Deploy Kubernetes Workloads

```bash
cd kubernetes/overlays/dev
kubectl apply -k .
    or
kubectl apply -f (filename)
```

Use `kubectl get pods` and `kubectl get svc` to check application and service status.

---

## 🧩 Terraform Modules

- `network/` – VPCs, subnets, firewall rules
- `gke-cluster/` – GKE provisioning
- `iam/` – IAM roles and service accounts

Each module is written to be reusable across environments.

---

## 🔐 Security Note

- Service accounts and IAM bindings should be scoped per environment.
- For secrets, consider integrating with **Google Secret Manager** or **HashiCorp Vault**.

---

## 📌 Roadmap

- [ ] Add GitHub Actions / Cloud Build pipelines for CI/CD
- [ ] Automate Terraform via remote backend (e.g. GCS + state locking)
- [ ] Add monitoring/logging setup using GCP’s Ops suite
- [ ] Secure secrets using GCP Secret Manager

---

## 📚 References

- [Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Kubernetes Docs](https://kubernetes.io/docs/home/)
- [GKE Best Practices](https://cloud.google.com/kubernetes-engine/docs/best-practices)

---

## 📝 License & Disclaimer

This codebase is shared for **portfolio and demonstration** purposes only.  
Forking or reuse without permission is discouraged. See LICENSE for more.

---

## 👨‍💻 Author

**Parth Koli**  
[GitHub](https://github.com/parth0607) | [LinkedIn](https://www.linkedin.com/in/parth-koli-80332a232/)
