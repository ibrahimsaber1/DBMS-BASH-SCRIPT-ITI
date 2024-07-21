#!/bin/bash

list_tables () {
    echo -e "\nList Tables\n"
    read -p "Enter the database name: " db_name
    
    # Check if the database exists
    if [ ! -d "./databases/$db_name" ]; then
        echo -e "\nDatabase $db_name does not exist!\n"
        list_tables # call the function again
    
    else
        cd "./databases/$db_name" || exit
        
        count=$(ls | wc -l)
        if [ $count -eq 0 ]; then
            echo -e "\nYou don't have any tables yet\n"
        else 
            echo -e "\nYour tables are:\n"
            ls
        fi
        echo ""
    fi
}
