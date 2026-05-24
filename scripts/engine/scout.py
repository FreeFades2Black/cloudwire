# The Scout's Ledger: Ingestion Logic
import yaml
from tfparse import load_from_path

class CloudWireScout:
    def __init__(self, project_path):
        self.project_path = project_path

    def scout_terraform_resources(self):
        parsed = load_from_path(self.project_path)
        # Tracking infrastructure foundations
        return [{"type": t, "name": n} for t, b in parsed.get('resource', {}).items() for n in b]

    def scout_k8s_manifests(self, yaml_file):
        with open(yaml_file, 'r') as file:
            return yaml.safe_load(file)
