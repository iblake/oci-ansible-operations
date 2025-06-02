## 🎬 Use Case: "Provision, Patch, and Validate an ExaCS Database"

---

### 🎯 Objective

Show how your automation framework can:

1. Dynamically discover infrastructure
2. Provision a new Autonomous or CDB database
3. Run a patch (in-place)
4. Validate the environment after patching

---

## 🔧 Setup (before the demo)

Ensure:

* You have valid access to OCI (`~/.oci/config`)
* The collection `oracle.oci` is installed:

  ```bash
  ansible-galaxy collection install oracle.oci
  ```
* You’ve filled the variables in `inventories/exacs/group_vars/all.yml`, e.g.:

```yaml
compartment_id: ocid1.compartment.oc1..example
region: eu-frankfurt-1
db_name: DEMODB
admin_password: "SecurePassword123"
cpu_core_count: 2
data_storage_size_in_tbs: 1
license_model: BRING_YOUR_OWN_LICENSE
```

---

## 🚀 Demo Flow

---

### ✅ Step 1: Validate infrastructure access

Check if the hosts are reachable:

```bash
make ping
```

📌 *This uses the dynamic inventory to connect to the DB nodes from OCI.*

---

### 🏗️ Step 2: Provision a new database

```bash
make create-db
```

📌 *This triggers `playbooks/provisioning/createPADBOHANS.yml`.*

➡️ This creates a new Autonomous or CDB database using the parameters defined in `group_vars/all.yml`.

---

### 🔍 Step 3: Gather facts about the new environment

```bash
ansible-playbook -i inventories/exacs/inventory.yml playbooks/diagnostic/getFacts.yml
```

📌 *This confirms the new DB is visible, online, and accessible.*

---

### 🛠️ Step 4: Run an in-place patch

```bash
make patch-inplace
```

This performs:

* ✅ `patchInPlaceCDB-precheck.yml` → Validates that patching prerequisites are met
* ✅ `patchInPlaceCDB-apply.yml` → Executes the patch

You can even show the precheck results with:

```bash
cat patch_inplace_output.json
```

(optional if you store output)

---

### 🔄 Step 5: Restart a PDB or CDB (if needed)

```bash
ansible-playbook -i inventories/exacs/inventory.yml -e pdb_name=DEMO_PDB roles/restart/tasks/restartPDB.yml
```

✅ *This shows modular automation logic for specific operational actions.*

---

### 📊 Step 6: Validate Post-Patch Health

```bash
ansible-playbook -i inventories/exacs/inventory.yml playbooks/diagnostic/getFacts.yml
```

➡️ Confirm DB uptime, version, and status.
✅ Optionally, you can display JSON output or log summaries for reporting.

---

## 🎁 Bonus: Advanced Add-ons

* 🔄 Use `roles/dataguard/` to demo switchover/failover automation
* 🔐 Explain how secrets can be protected using `ansible-vault`
* 📦 Show how roles are reusable and extensible (e.g., scale or restart)

---

## 📽️ Suggested Demo Narrative

> “Let’s walk through how we provision and manage an ExaCS DB in under 10 minutes.
> We’ll dynamically discover the infrastructure, deploy a secure database, apply a patch, and verify health — all using clean, repeatable automation that your team can maintain or extend.”
