#!/bin/bash

connect_to_database() {
    echo "Connect to Database"
    read -p "Enter database name: " db_name
    if [ -d "$db_name" ]; then
        echo "Connected to database $db_name"
        connected_db_menu $db_name
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
            2) list_tables $db_name ;;
            3) drop_table $db_name ;;
            4) insert_into_table $db_name ;;
            5) select_from_table $db_name ;;
            6) delete_from_table $db_name ;;
            7) update_table $db_name ;;
            8) break ;;
            *) echo "Invalid choice!" ;;
        esac
    done
}

connect_to_database