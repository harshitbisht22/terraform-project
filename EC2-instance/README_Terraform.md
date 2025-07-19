# 🚀 Terraform Project Structure & Best Practices

## 📌 1. Basic Terraform Concepts

| Concept             | Description                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| **Provider**        | Defines the cloud/platform to interact with (e.g., AWS, Azure, GCP).        |
| **Input Variable**  | Takes external input values via `.tfvars` or CLI (`-var`).                  |
| **Resource**        | Actual infrastructure component you want to create (e.g., EC2, S3).         |
| **Output Variable** | Displays values after apply (e.g., IPs, ARNs). Useful for chaining.         |

---

## 📁 2. Standard File Structure

```bash
project/
├── main.tf              # Resource definitions
├── provider.tf          # Cloud provider configuration
├── variables.tf         # Input variable declarations
├── terraform.tfvars     # Input values for variables
├── outputs.tf           # Output variable declarations
├── terraform.tfstate    # (Auto-generated) State file
├── terraform.lock.hcl   # (Auto-generated) Provider version lock
```

---

## ⚙️ 3. Sample Terraform Files

### 🛠 provider.tf

```hcl
provider "aws" {
  region = var.aws_region
}
```

### 🧮 variables.tf

```hcl
variable "aws_region" {}
variable "ami_id" {}
variable "instance_type" {}
```

### 🧾 terraform.tfvars

```hcl
aws_region     = "us-east-1"
ami_id         = "ami-123456"
instance_type  = "t2.micro"
```

### 🧱 main.tf

```hcl
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
}
```

### 📤 outputs.tf

```hcl
output "instance_ip" {
  value = aws_instance.web.public_ip
}
```

---

## 🧠 4. Making Terraform Reusable with Modules

### ✅ Benefits

- **DRY** (Don't Repeat Yourself)
- Scalable and maintainable
- Logical code reuse

### 📂 Folder Structure with Modules

```bash
project-root/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── modules/
│   └── ec2_module/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
```

### 🔗 Calling the Module (Root `main.tf`)

```hcl
module "my_ec2" {
  source        = "./modules/ec2_module"
  ami_id        = var.ami_id
  instance_type = var.instance_type
}
```

### 🧱 modules/ec2_module/main.tf

```hcl
resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
}
```

### 📥 modules/ec2_module/variables.tf

```hcl
variable "ami_id" {}
variable "instance_type" {}
```

### 📤 modules/ec2_module/outputs.tf

```hcl
output "instance_id" {
  value = aws_instance.this.id
}
```

---

## ✅ Best Practices & Commands

- Use `terraform fmt` for formatting
- Use `terraform validate` to catch syntax issues
- Store state in remote backend for teams (e.g., S3 + DynamoDB lock)
- Lock provider versions with `.terraform.lock.hcl`

---

### 🔧 Common Commands

```bash
# Initialize Terraform working directory
terraform init

# Validate syntax and configuration
terraform validate

# Plan and apply when using terraform.tfvars
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

---

### 📘 Note on Using Modules

- When you use **modules**, you typically **pass variable values directly in the module block**, not through `terraform.tfvars`.

✅ Example:
```hcl
module "my_ec2" {
  source        = "./modules/ec2_module"
  ami_id        = "ami-123456"
  instance_type = "t2.micro"
}
```

🚫 No need for a separate `terraform.tfvars` unless you're abstracting values even further.

---

> Created by **Harshit Bisht** 🛠️ | [GitHub](https://github.com/harshitbisht22)
