# oci-ansible-operations

This repository contains a collection of reusable Ansible playbooks and roles designed to automate operations on Oracle Exadata Cloud Service (ExaCS) and other OCI (Oracle Cloud Infrastructure) components.

It aims to accelerate operational tasks, reduce manual errors, and provide a standardized automation foundation for OCI environments.

---

## 📌 Purpose

`oci-ansible-operations` helps you:

- Automate infrastructure discovery, diagnostics, and configuration tasks in OCI
- Interact with Exadata infrastructure, VM clusters, and databases via Ansible
- Standardize cloud operations across environments (dev, prod, staging)
- Reduce the time required to perform repetitive and error-prone tasks

---

## ✅ Prerequisites

Before using this repository, ensure you have the following:

- **Python**: `>=3.8`
- **Ansible**: `>=2.15`  
- **OCI CLI Configured** (with a valid `~/.oci/config` file)
- An OCI **user with proper permissions** to inspect and manage Exadata resources
- Optional: Create a **virtual environment** for isolated Ansible dependencies

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
````

---

## 📁 Repository Structure

```bash
.
├── ansible.cfg               # Ansible configuration
├── inventories/              # Static or dynamic inventories for OCI resources
├── playbooks/                # Main entrypoint playbooks for common operations
├── roles/                    # Ansible roles for modular task reuse
├── vars/                     # Variable definitions
├── docs/                     # Documentation and diagrams
└── Makefile                  # Automation commands for common tasks
```

---

## 🚀 Installation & Usage

You can run a playbook using the following command:

```bash
ansible-playbook -i localhost, playbooks/diagnostic/getExaCSInfraOnly.yml \
  -e "region=eu-frankfurt-1 \
      compartment_id=ocid1.compartment.oc1..xxxx \
      vm_cluster_compartment_id=ocid1.compartment.oc1..yyyy"
```

The playbooks are designed to run locally using the OCI Python SDK and your OCI CLI credentials.

> ✅ Pro tip: Always run `ansible-lint` before committing playbooks to check for issues.

---

## 🧪 Example Use Cases

* **Get Exadata Infrastructure details** from a specific region and compartment
* **Patch planning** using diagnostics and configuration facts
* **Cross-tenancy reporting** by looping over inventories
* **Integrate with CI/CD pipelines** (e.g., GitHub Actions) for automated operations

---

## 📚 Documentation

Check the [`docs/`](docs/) folder for:

* Diagrams of Exadata resources
* Inventory examples
* How to extend existing roles

---

## 🤝 Contributions

Pull requests are welcome! See [`CONTRIBUTING.md`](CONTRIBUTING.md) for details.

---

## 🛡️ License

This project is licensed under the MIT License - see the [`LICENSE`](LICENSE) file for details.
