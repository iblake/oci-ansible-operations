
# 📦 OCI Ansible Automation for Exadata Cloud Service (ExaCS)

This repository provides a structured and scalable framework to automate operational tasks on **Oracle Exadata Cloud Service (ExaCS)** within **Oracle Cloud Infrastructure (OCI)** using **Ansible**.

---

## 🎯 Purpose

This automation toolkit is intended to:

- Streamline provisioning, maintenance, and patching of databases on ExaCS.
- Reduce human error by codifying repeatable operational processes.
- Support GitOps and CI/CD models in enterprise cloud environments.
- Enable knowledge transfer across operational teams with minimal onboarding.

---

## 🧱 Repository Structure

```
.
├── README.md                    # Short overview and quick commands
├── ansible.cfg                 # Ansible global configuration
├── Makefile                    # Predefined tasks for quick execution
├── dbhosts.oci.yml             # Optional static variables for hosts
├── docs/
│   └── README_FULL.md          # This extended documentation
├── hosts                       # Optional static inventory file
├── inventories/
│   └── exacs/
│       ├── group_vars/
│       │   └── all.yml         # Global variables for OCI setup
│       └── inventory.yml       # OCI dynamic inventory configuration
├── playbooks/
│   ├── diagnostic/             # Info gathering and testing playbooks
│   ├── maintenance/            # (future) System maintenance routines
│   ├── patching/               # (future) Patching orchestration
│   └── provisioning/           # Database provisioning playbooks
├── roles/
│   ├── create_db/              # Tasks to create/delete CDB, PDB, OH
│   ├── dataguard/              # Data Guard automation tasks
│   ├── diagnostic/             # Get infrastructure and patch metadata
│   ├── patch_outofplace/       # Out-of-place patching logic
│   ├── restart/                # Restart operations (CDB, PDB, VMs)
│   └── scale/                  # VM shape/CPU scaling
```

---

## 🧠 Component Breakdown

### 🔧 Configuration

- **`ansible.cfg`**: Defines global Ansible behavior (e.g., callback output, roles path).
- **`Makefile`**: Provides shortcuts for common operations:
  ```bash
  make ping           # Check connectivity
  make create-db      # Create a new database
  make patch-inplace  # Run in-place patching
  make list-buckets   # List Object Storage buckets
  ```

---

### 📂 Inventories

- **`inventory.yml`**: Uses `oracle.oci.oci` plugin to dynamically fetch DB hosts from OCI.
- **`group_vars/all.yml`**: Stores shared values like:
  - `compartment_id`
  - `db_name`, `admin_password`
  - `region`, `cpu_core_count`
  - Other provisioning variables

---

### 🧩 Playbooks

Playbooks are grouped by their purpose:

| Folder           | Purpose                                              |
|------------------|------------------------------------------------------|
| `diagnostic/`    | Ping, get facts, list buckets                        |
| `provisioning/`  | Deploy new DBs or infrastructure resources           |
| `patching/`      | Future orchestration using patch roles               |
| `maintenance/`   | Reserved for backups, restarts, monitoring actions  |

---

### 🎭 Roles

Modular logic reusable across environments. Each role contains:

- `tasks/*.yml`: Atomic operations
- `tasks/main.yml`: Imports all steps in sequence

Example roles:
- `create_db`: Handles creation/deletion of databases, OH, PDB
- `dataguard`: Manages switchover/failover/reinstates
- `patch_outofplace`: Applies patches without affecting production directly
- `restart`: Controlled restart operations
- `scale`: Resizes VM clusters

---

## 🚀 Quick Start: Common Operations

### ✅ Connectivity check

```bash
make ping
```

### 🆕 Provision a new Autonomous Database

```bash
make create-db
```

This launches the `createPADBOHANS.yml` playbook, which provisions a new database based on the variables in `group_vars/all.yml`.

### 🩹 In-place patch execution

```bash
make patch-inplace
```

This runs two sequential tasks:
- `patchInPlaceCDB-precheck.yml`
- `patchInPlaceCDB-apply.yml`

---

## 🔐 Security Considerations

- Passwords (e.g., `admin_password`) **must be encrypted** using [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) or stored securely using **OCI Vault** in production.
- Avoid pushing any secrets to Git repositories — use `.gitignore` and secrets managers.

---

## 🧪 Best Practices

- Use `ansible-lint` and `yamllint` to enforce syntax and structure.
- Keep separate variable files for `dev`, `staging`, and `prod` environments.
- Include preflight checks in all patching operations.
- Include rollback mechanisms for any destructive action.

---

## 🌐 Future Improvements

- CI/CD integration with GitHub Actions or GitLab CI
- Full GitOps-based flow for patch lifecycle
- Monitoring with metrics collection
- Automated rollback and health validation

---

## 🤝 Who Should Use This Repo?

This repository is designed for:

- Cloud operations engineers managing ExaCS environments
- OCI architects looking to standardize operational workflows
- DevOps teams incorporating infrastructure automation
- Partners and customers seeking repeatable deployments

---

## 📞 Support & Handover

This documentation serves as a **complete onboarding guide**. If you're a client receiving this repository:

- Review `README.md` for quick commands.
- Explore `docs/README_FULL.md` for full context.
- Run `make help` to discover available automations.

With minimal effort, your team can manage, patch, and scale ExaCS environments securely and reliably.