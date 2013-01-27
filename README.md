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
            "enable_pitti_ppa": true,
            "client": {
                "packages": ["postgresql-client-9.2", "postgresql-contrib-9.2", "libpq-dev"]
            },
            "server": {
                "packages": ["postgresql-9.2", "postgresql-server-dev-9.2"]
            },
            "password": {
                "postgres": "default_password"
            }
        }
    },
    "run_list": [
        "recipe[postgresql::ppa_pitti_postgresql]",
        "recipe[postgresql::server]",
        "recipe[pgrest]"
    ]
}
```
