#!/bin/bash

delete_from_table() {
    local db_name=$1
    read -p "Enter table name to delete from: " table_name
    if [ -f "$db_name/$table_name" ]; then
        read -p "Enter the row number to delete: " row_number
        sed -i "${row_number}d" "$db_name/$table_name"
        echo "Row $row_number deleted from table $table_name in database $db_name."
    else
        echo "Table $table_name does not exist in database $db_name!"
    fi
}
