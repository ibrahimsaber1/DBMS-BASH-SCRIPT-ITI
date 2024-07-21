#!/bin/bash

list_tables() {
    echo -e "\nList Tables\n"
    
    # Find all files ending with .table
    tables=$(ls *.table 2> /dev/null)
    
    if [ -z "$tables" ]; then
        echo -e "\nYou don't have any tables yet\n"
    else 
        echo -e "\nYour tables are:\n"
        for table in $tables; do
            echo "$table"
        done
    fi
    echo ""
}
