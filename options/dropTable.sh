#!/bin/bash

drop_table() {
    echo -e "\nDrop Table\n"
    read -p "Please enter the name of the table: " table_name

    # Check if the table name is empty
    if [ -z "$table_name" ]; then
        echo -e "\nPlease enter a correct name\n"
        drop_table # call the function again

    # Check if the table exists
    elif [ -f "$table_name" ]; then
        rm "$table_name" 2>/dev/null
        rm ./.metaData_"$table_name" 2>/dev/null
        echo -e "\nTable dropped successfully\n"

    else
        echo -e "\nTable $table_name not found\n"
    fi

    read -p "Press any key to return to the menu..." -n1 -s
}
