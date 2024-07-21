#!/bin/bash

list_tables() {
    echo -e "\nList Tables\n"
    
    count=$(ls -1 | wc -l)
    if [ $count -eq 0 ]; then
        echo -e "\nYou don't have any tables yet\n"
    else 
        echo -e "\nYour tables are:\n"
        for table in $(ls -p | grep -v /); do
            echo "$table"
        done
    fi
    echo ""
}
