#!/bin/bash

create_database() {
    echo "Create Database"
    read -p "Enter the name of the database please: " db_name
    
    # Ensure the databases directory exists
    mkdir -p ./databases

    # Check if the database name is empty
    if [ -z "$db_name" ]; then
        echo -e "\nPlease enter a correct name\n"
        create_database # call the function again
    
    # Check if the database name contains spaces
    elif [[ "$db_name" = *[[:space:]]* ]]; then
        echo -e "\nDatabase name cannot contain spaces\n"
        create_database # call the function again
    
    # Check if the directory already exists in the databases directory
    elif [ -d "./databases/$db_name" ]; then
        echo -e "\nThis database name already exists, please choose another name\n"
        create_database # call the function again

    # Check if the database name starts with an alphabetic character
    elif [[ "$db_name" == [a-zA-Z]* ]]; then
        mkdir ./databases/$db_name 2>/dev/null
        echo -e "\nDatabase $db_name created successfully!\n"
    
    # If the database name does not start with an alphabetic character
    else
        echo -e "\nPlease enter a correct name\n"
        create_database # call the function again
    fi
}

# create_database
