# Automated Infrastructure & Application Deployment CI/CD Pipeline

A production-grade, GitOps-driven architecture that automates infrastructure provisioning and application deployment using **Infrastructure as Code (IaC)** and **CI/CD practices**. 

This project achieves a strict **separation of concerns** by decoupling core management infrastructure, application code, and application-specific cloud infrastructure into isolated lifecycle repositories.

---

## 🏗️ Architecture Overview

The system is decoupled across three distinct Git repositories to ensure high modularity and blast-radius isolation:

1. **Management Infrastructure (Repo - terraform-jenkins):** Provisions the core CI/CD environment. Uses **Terraform** to deploy a dedicated VPC, Subnets, an Application Load Balancer (ALB), and an **Amazon EC2** instance hosting the automated **Jenkins CI/CD Server**.
2. **Application Source Code (Repo - ../py-mysql-db-app):** Contains the functional backend logic, written as a modular **Python Application**.
3. **Application Environment Infrastructure (Repo - terraform-infra):** Defines the isolated target runtime environment. Uses **Terraform** to provision the specific production networking (VPC, Subnets, ALBs), data layers (**Amazon RDS SQL** instances), and required compute resources for the Python app.

---

## ⚙️ Core CI/CD Engine Workflow

When code updates or infrastructure modifications are pushed to Git, the architecture orchestrates the following automated lifecycle:

```text
[Developer Push] ➡️ [Git Trigger] ➡️ [Jenkins Server] ➡️ [Clones Infra Repo] ➡️ [Terraform Init/Plan/Apply] ➡️ [Live Application]
```

* **Pipeline Automation:** The Jenkins server hosts an automated pipeline triggered dynamically by repository updates via webhooks.
* **Stateful Orchestration:** Jenkins pulls the infrastructure definitions from the environment repository and executes sequential lifecycle stages: `terraform init`, `terraform plan`, and `terraform apply`.
* **Dynamic Provisioning:** The pipeline deterministically constructs or scales the environment, safely mapping target groups and deploying the Python application to its freshly provisioned resources.

---

## 🛠️ Tech Stack & Skills Demonstrated

* **Infrastructure as Code (IaC):** Terraform (Modular layouts, Providers, Resource Graph dependencies)
* **Cloud Platform:** Amazon Web Services (AWS) — VPC, EC2, ALB, Target Groups, RDS SQL, IAM Roles
* **Continuous Integration & Deployment (CI/CD):** Jenkins (Pipeline-as-Code, Automation Plugins, Webhooks)
* **Programming & Scripting:** Python, Bash/Shell Scripting
* **Methodologies:** GitOps, Architecture Decoupling, Principle of Least Privilege (IAM)
