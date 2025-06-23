#!/bin/bash
wget ""
# Read variable names from var.txt and find their values in CSF config
while IFS= read -r var_name; do
    # Skip empty lines and comments
    [[ -z "$var_name" || "$var_name" =~ ^[[:space:]]*# ]] && continue

    # Find the variable in CSF config and extract its value
    var_value=$(grep "^$var_name[[:space:]]*=" /etc/csf/csf.conf | sed 's/.*=[[:space:]]*"\?\([^"]*\)"\?.*/\1/')

    if [[ -n "$var_value" ]]; then
        export "$var_name=$var_value"
        echo "Exported: $var_name=$var_value"
    else
        echo "Warning: $var_name not found in CSF config"
    fi
done < var.txt
