class Rule:
    id = "101"
    description = "Admin name must not be 'root'"
    severity = "HIGH"
    paths = ["meraki"]  # ensures this rule is applied to Meraki data

    @classmethod
    def match(cls, data, schema=None):
        violations = []

        # Check if "meraki" key exists
        meraki_data = data.get("meraki", {})
        domains = meraki_data.get("domains", [])

        for domain in domains:
            administrator = domain.get("administrator", {})
            admin_name = administrator.get("name", "")

            if admin_name.lower() == "root":
                domain_name = domain.get("name", "unknown domain")
                violations.append(
                    f"Admin name must not be 'root' in domain '{domain_name}'"
                )

        return violations
