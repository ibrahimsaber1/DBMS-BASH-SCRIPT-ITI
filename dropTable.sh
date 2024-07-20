#!/bin/bash

drop_table() {
    local db_name=$1
    read -p "Enter table name to drop: " table_name
    if [ -f "$db_name/$table_name" ]; then
        rm "$db_name/$table_name"
        echo "Table $table_name has been dropped from database $db_name."
    else
        echo "Table $table_name does not exist in database $db_name!"
    fi
}
