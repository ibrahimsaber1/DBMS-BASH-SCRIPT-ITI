#!/bin/bash

drop_database() {
    echo "Drop Database"
    read -p "Enter database name to drop: " db_name
    if [ -d "$db_name" ]; then
        rm -r "$db_name"
        echo "Database $db_name has been dropped."
    else
        echo "Database $db_name does not exist!"
    fi


}
