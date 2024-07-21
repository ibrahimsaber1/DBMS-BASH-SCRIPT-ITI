#!/bin/bash

# Function to list all databases
list_databases() {
    count=$(ls -f "./databases"|wc -l)
    if [ $count -eq 0 ]; then
        echo -e "\nYou don't have any databases yet\n"
    else 
        echo -e "\nYour databases are:\n"
        ls ./databases
    fi
    echo ""
}


