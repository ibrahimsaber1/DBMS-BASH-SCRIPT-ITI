#!/bin/bash

delete_from_table() {
    echo "Delete From Table"
    echo "Available tables:"
    ls *.table 2>/dev/null
    echo "Enter the table name to delete from:"
    read table_name

    if [ -f "$table_name.table" ]; then
        echo "Current data in $table_name:"
        
        # Display the table with row numbers
        nl -w 3 -s '. ' "$table_name.table"
        
        echo "Enter the row number to delete:"
        read row_number
        

        # Confirm deletion
        echo "Are you sure you want to delete row $row_number? (yes/no)"
        read confirmation
        
        if [ "$confirmation" == "yes" ]; then
            # Delete the specified row
            sed -i "${row_number}d" "$table_name.table"
            echo "Row $row_number has been deleted from $table_name."
        else
            echo "Deletion canceled."
        fi
    else
        echo "Table $table_name does not exist."
    fi

}

delete_from_table
