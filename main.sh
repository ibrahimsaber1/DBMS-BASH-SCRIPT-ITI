#!/bin/bash

# Source the individual function scripts
source ./options/connectToDataBase.sh
source ./options/dropDataBase.sh
source ./options/dropTable.sh
source ./options/insertIntoTable.sh
source ./options/deleteFromTable.sh
source ./options/createDataBase.sh
source ./options/listDataBase.sh

# Main Menu Function
main_menu() {
    while true; do
        clear
        echo "Main Menu"
        echo "1. Create Database"
        echo "2. List Databases"
        echo "3. Connect To Database"
        echo "4. Drop Database"
        echo "5. Exit"
        read -p "Enter your choice: " choice
        case $choice in
            1) create_database ;;
            2) list_databases ;;
            3) connect_to_database ;;
            4) drop_database ;;
            5) exit 0 ;;
            *) echo "Invalid choice!" ;;
        esac
        read -p "Press any key to return to the main menu..." -n1 -s
    done
}

# Placeholder Functions for create_database and list_databases
# create_database() {
#     echo "Create Database"
# }

# list_databases() {
#     echo "List Databases"
# }

# Start the main menu
main_menu
