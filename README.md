# Description

sets up pgrest deps

I use the following role file:

```json
{
    "name": "pgrest",
    "chef_type": "role",
    "json_class": "Chef::Role",
    "override_attributes": {
        "postgresql": {
            "version": "9.2",
            "enable_pgdg_apt": true,
            "password": {
                "postgres": "default_password"
            }
        }
    },
    "run_list": [
        "recipe[pgrest]"
    ]
}
```
