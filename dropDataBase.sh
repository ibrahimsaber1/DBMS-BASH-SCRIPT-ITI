#!/bin/bash

drop_database() {
    echo "Drop Database"
    read -p "Enter database name to drop: " db_name
    db_name=$(echo "$db_name" | xargs)  # Trim whitespace

    if [ -z "$db_name" ]; then
        echo "Database name cannot be empty!"
        return
    fi

    if [ -d "$db_name" ]; then
        # Confirm deletion
        echo "Are you sure you want to drop the database '$db_name'? This action cannot be undone. (yes/no)"
        read confirmation
        confirmation=$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
        
        if [ "$confirmation" == "yes" ]; then
            # Attempt to remove the directory and handle errors
            if rm -r "$db_name"; then
                echo "Database $db_name has been dropped."
            else
                echo "Failed to drop database $db_name. Please check your permissions or try again."
            fi
        else
            echo "Database drop canceled."
        fi
    else
        echo "Database $db_name does not exist!"
    fi
}


drop_database
