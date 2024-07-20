#!/bin/bash

# Source the individual function scripts
source ./connectToDataBase.sh
source ./dropDataBase.sh
source ./dropTable.sh
source ./insertIntoTable.sh
source ./deleteFromTable.sh

# Main Menu Function
main_menu() {
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
}

# Placeholder Functions for create_database and list_databases
create_database() {
    echo "Create Database"
}

list_databases() {
    echo "List Databases"
}


main_menu
