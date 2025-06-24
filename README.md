
# 🌥️ Cloud-Native GCP Deployment

This repository provides a modular and reusable setup for deploying infrastructure and containerized applications on **Google Cloud Platform (GCP)** using **Terraform** and **Kubernetes (GKE)**. 

> 🔧 CI/CD is integrated using **GitHub Actions** with **OIDC authentication** to securely deploy infrastructure and workloads to GCP.

---

## 🚀 Overview

- Infrastructure as Code using **Terraform**
  - VPC, GKE cluster, IAM, Artifact Registry, etc.
- Kubernetes deployment setup using **kubectl** or **Kustomize**
- Environment-specific configurations (dev, pre-prod, prod)

---

## 📁 Repository Structure

```
cloud-native-gcp-deployment/
├── terraform/
│   ├── modules/            # Reusable Terraform modules (network, GKE, IAM)
│   ├── dev/                # Dev environment configurations
│   ├── pre-prod/
│   └── prod/
├── kubernetes/
│   ├── base/               # Shared k8s resources (ConfigMaps, Secrets)
│   └── overlays/           # Environment-specific deployment configs
│       ├── dev/
│       ├── pre-prod/
│       └── prod/
│   └── gateway/            # Gateway and HTTPRoute configurations
├── scripts/
│   └── bootstrap.sh        # Optional helper script for provisioning
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

> Note: Here we can utilise two methods of connecting to the cluster:
>  1. By authorising our working environment IP address/range in the Authorised network section of the control plane,
>  2. By using flag `--dns-endpoint`, this is a newly introduced feature of GKE which authorises the user based on the IAM level roles/permissions. Here the user need to have the role of "Kubernetes Developer" for accessing the GKE cluster using this flag.

  Example for `--dns-endpoint`
  ```bash
  gcloud container clusters get-credentials <CLUSTER_NAME> --zone us-central1-c --dns-endpoint
  ```


### 4. Deploy Kubernetes Workloads

```bash
cd kubernetes/overlays/dev
kubectl apply -k .
```

Use `kubectl get pods` and `kubectl get svc` to check application and service status.

---

## 🧩 Terraform Modules

- `network/` – VPCs, subnets, firewall rules
- `gke-cluster/` – GKE provisioning
- `iam/` – IAM roles and service accounts

Each module is written to be reusable across environments, and follows the root and calling modules structure with GCS buckets mapped as the backend to store and maintain the terraform states across the whole project.

---

## 🔐 Security Note

Service accounts and IAM bindings should be scoped per environment.

For secrets, consider integrating with Google Secret Manager or HashiCorp Vault.

---

## 🔐 GKE Gateway with HTTPS (SSL/TLS)

This project uses GKE Gateway API with HTTPS support to expose Kubernetes workloads securely using SSL certificates.

### 🧱 Components

- **Gateway API:** Uses `gke-l7-global-external-managed` class
- **HTTPS Listener:** Listens on port 443 with TLS termination
- **HTTPRoute:** Routes traffic from custom domain(s) to the backend services
- **SSL Certificate:** A Google-managed wildcard certificate is used for TLS

### 📁 File Locations

```bash
kubernetes/base/gateway/
├── gateway.yaml        # HTTPS Gateway definition
├── httproute.yaml      # Routes traffic to your app service
```

### ⚙️ Setup Instructions

#### Reserve a Static IP Address (optional but recommended)

```bash
gcloud compute addresses create my-gateway-ip   --global   --ip-version=IPV4
```

## 🌐 Google Certificate Manager – Full HTTPS Setup with GKE Gateway

To enable HTTPS using a custom domain in GKE Gateway, we follow a multi-step process involving **domain authorization**, **wildcard certificate creation**, and **certificate map configuration**.

### 1. 🔐 Domain Authorization

Before creating a certificate, you must prove ownership of the domain.

```bash
gcloud certificate-manager dns-authorizations create wildcard-yourdomain-com-auth \
  --domain="*.yourdomain.com" \
  --project=YOUR_PROJECT_ID
```

### 📜 Create a Wildcard SSL Certificate
Once the domain is authorized (DNS record is propagated), you can create a managed wildcard certificate:
```bash
gcloud certificate-manager certificates create wildcard-yourdomain-com-cert \
  --domains="*.yourdomain.com" \
  --dns-authorizations=wildcard-yourdomain-com-auth \
  --project=YOUR_PROJECT_ID
```

### 🗺️ Create a Certificate Map
A certificate map helps route traffic to the correct certificate based on the domain name:
```bash
gcloud certificate-manager maps create wildcard-map \
  --project=YOUR_PROJECT_ID
```

Then bind the certificate to this map using a map entry:
```bash
gcloud certificate-manager map-entries create wildcard-map-entry \
  --map=wildcard-map \
  --hostname="*.yourdomain.com" \
  --certificates=wildcard-yourdomain-com-cert \
  --project=YOUR_PROJECT_ID
```

🚪 Reference the Certificate Map in GKE Gateway
In your `gateways.yaml`, reference the certificate map by supplying the map that is created follwing the above steps, and add the below argument:

```bash
annotations:
    networking.gke.io/certmap: cert-map
```

### 🔁 HTTP → HTTPS Redirect (Optional)

To redirect HTTP traffic to HTTPS, you can configure a second HTTPRoute and forward with a 301 redirect rule.

### 🌐 Domain Setup

Ensure your domain (e.g. `*.your-domain.com`) points to the static IP or the IP created by the Gateway Load Balancer. Update your DNS A record accordingly.

---

## ⚙️ CI/CD with GitHub Actions (OIDC Authentication)

This project integrates GitHub Actions for automated CI/CD pipelines to deploy infrastructure and Kubernetes workloads to GCP.

### 📂 Workflow File

- `.github/workflows/workflow.yaml`: Main CI/CD workflow for Terraform + Kubernetes deployment

### 🔐 Authentication via OIDC

Instead of using long-lived service account keys, the workflow uses GitHub OIDC (OpenID Connect) to authenticate securely to Google Cloud.

This allows GitHub to act as an identity provider, issuing a short-lived access token during workflow execution.

### ✅ Setup Requirements

- Enable Workload Identity Federation on GCP
- Create a Service Account with the necessary IAM roles
- Allow GitHub OIDC provider access to assume the service account
- Reference the provider and service account in your workflow using `GOOGLE_WORKLOAD_IDENTITY_PROVIDER` and `GOOGLE_SERVICE_ACCOUNT`

### 🛠️ Pipeline Tasks (from `workflow.yaml`)

- Checkout repo
- Set up Terraform
- Authenticate to Google Cloud using OIDC
- Initialize and apply Terraform
- Set up kubectl
- Deploy Kubernetes manifests

This setup avoids committing service account keys to the repo and supports least-privilege, auditable access.

---

## 📚 References

- [Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Kubernetes Docs](https://kubernetes.io/docs/)
- [GKE Best Practices](https://cloud.google.com/kubernetes-engine/docs/best-practices)

---

## 📝 License & Disclaimer

This codebase is shared for portfolio and demonstration purposes only.
Forking or reuse without permission is discouraged. See LICENSE for more.

---

## 👨‍💻 Author

**Parth Koli**  
[GitHub](https://github.com/parth0607/cloud-native-gcp-deployment) | [LinkedIn](https://www.linkedin.com/in/parth-koli-80332a232/)


</br>

#### 🛠️ Ongoing Work

Upcoming projects/scenarios include:

- Production ready GCP Shared VPC structured environment.   
- Advanced CI/CD using ArgoCD and Github Actions. 


Stay tuned for updates!

