#!/bin/bash

drop_table() {
    echo -e "\nDrop Table\n"
    read -p "Please enter the name of the table: " table_name

    # Trim whitespace
    table_name=$(echo "$table_name" | xargs)

    # Check if the table name is empty
    if [ -z "$table_name" ]; then
        echo -e "\nTable name cannot be empty!\n"
        drop_table # call the function again

    # Check if the table exists
    elif [ -f "$table_name.table" ]; then
        # Confirm deletion
        echo -e "\nAre you sure you want to drop the table '$table_name'? This action cannot be undone. (yes/no)"
        read confirmation
        confirmation=$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
        
        if echo "$confirmation" | grep -iq "^yes$"; then
            rm "$table_name.table" 2>/dev/null
            rm "metaData_$table_name" 2>/dev/null
            echo -e "\nTable dropped successfully\n"
        else
            echo -e "\nTable drop canceled.\n"
        fi

    else
        echo -e "\nTable $table_name not found\n"
    fi

}
