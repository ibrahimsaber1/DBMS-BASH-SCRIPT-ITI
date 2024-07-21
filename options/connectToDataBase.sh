#!/bin/bash

connect_to_database() {
    echo "Connecting to Database"
    read -p "Enter database name: " db_name
    
    if [ -d "./databases/$db_name" ]; then
        echo "Connected to database $db_name"
        cd "./databases/$db_name" || exit  # Change to the database directory
        # echo "Current directory: $(pwd)"  # Print the current directory
        connected_db_menu $db_name
        cd - || exit  # Return to the previous directory after disconnecting
        # echo "Returned to directory: $(pwd)"  # Print the directory after returning
    else
        echo "Database $db_name does not exist!"
    fi
}

connected_db_menu() {
    local db_name=$1
    while true; do
        clear
        echo "Database $db_name Menu"
        echo "1. Create Table"
        echo "2. List Tables"
        echo "3. Drop Table"
        echo "4. Insert into Table"
        echo "5. Select From Table"
        echo "6. Delete From Table"
        echo "7. Update Table"
        echo "8. Disconnect"
        read -p "Enter your choice: " choice
        case $choice in
            1) create_table $db_name ;;
            2) list_tables ;;  # No need to pass $db_name
            3) drop_table $db_name ;;
            4) insert_into_table $db_name ;;
            5) select_from_table $db_name ;;
            6) delete_from_table $db_name ;;
            7) update_table $db_name ;;
            8) break ;;  # Exit the loop to disconnect
            *) echo "Invalid choice!" ;;
        esac
        read -p "Press any key to return to the menu..." -n1 -s
    done
}
