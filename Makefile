
# Variables
INVENTORY = inventories/exacs/oci_inventory.yml

## Help
help:
	@echo "Available commands:"
	@echo "  make ping           → Test connectivity to ExaCS nodes"
	@echo "  make create-db      → Provision a new database"
	@echo "  make patch-inplace  → Run in-place patching (precheck + apply)"
	@echo "  make list-buckets   → List Object Storage buckets"
	@echo "  make test           → Run validation without making changes"

## Connectivity Test
ping:
	ansible -i $(INVENTORY) all -m ping

## Provisioning
create-db:
	ansible-playbook -i $(INVENTORY) playbooks/provisioning/createPADBOHANS.yml

## In-place Patching
patch-inplace:
	ansible-playbook -i $(INVENTORY) roles/patchInPlaceCDB-precheck.yml
	ansible-playbook -i $(INVENTORY) roles/patchInPlaceCDB-apply.yml

## Object Storage Diagnostic
list-buckets:
	ansible-playbook -i $(INVENTORY) playbooks/diagnostic/list_buckets.yml

## Test - No changes applied
test:
	@echo "🔍 Running connectivity check..."
	ansible -i $(INVENTORY) all -m ping
	@echo "📡 Gathering host facts (read-only)..."
	ansible-playbook -i $(INVENTORY) playbooks/diagnostic/getFacts.yml
	@echo "🧪 Dry-run: simulate DB provisioning (no changes)..."
	ansible-playbook -i $(INVENTORY) playbooks/provisioning/createPADBOHANS.yml --check
