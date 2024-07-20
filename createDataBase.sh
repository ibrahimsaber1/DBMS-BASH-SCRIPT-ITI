#!/bin/bash

create_database() {
    echo "Create Database"
    read -p "Enter the name of the database please: " db_name
    
    # Check if the database name is empty
    if [ -z "$db_name" ]; then
        echo -e "\nPlease enter a correct name\n"
    
    # Check if the database name contains spaces
    elif [[ "$db_name" = *[[:space:]]* ]]; then
        echo -e "\nDatabase name cannot contain spaces\n"
    
    # Check if the directory already exists
    elif [ -d "$db_name" ]; then
        echo -e "\nThis database name already exists, please choose another name\n"
    
    # Check if the database name starts with an alphabetic character
    elif [[ "$db_name" == [a-zA-Z]* ]]; then
        mkdir ./$db_name 2>/dev/null
        echo -e "\nDatabase $db_name created successfully!\n"
    
    # If the database name does not start with an alphabetic character
    else
        echo -e "\nPlease enter a correct name\n"
    fi
}
