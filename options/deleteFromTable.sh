#!/bin/bash

delete_from_table() {
    echo "Delete From Table"
    
    while true; do
        echo "Available tables:"
        ls *.table 2>/dev/null
        echo "Enter the table name to delete from:"
        read table_name

        # Ensure the table name input is valid
        if [[ -z "$table_name" || ! "$table_name" =~ ^[a-zA-Z0-9_]+$ ]]; then
            echo "Invalid table name. It must not be empty and can only contain alphanumeric characters and underscores."
            continue
        fi
        
        if [ -f "$table_name.table" ]; then
            break
        else
            echo "Error: Table $table_name does not exist."
            continue
        fi
    done
    
    while true; do
        echo "Current data in $table_name:"
        
        # Display the table with row numbers
        nl -w 3 -s '. ' "$table_name.table"
        
        echo "Enter the row number to delete:"
        read row_number
        
        # Validate that the row number is a positive integer
        if [[ ! "$row_number" =~ ^[0-9]+$ ]] || [ "$row_number" -lt 1 ]; then
            echo "Invalid row number. Please enter a positive integer."
            continue
        fi
        
        # Check if the row number is within the range of existing rows
        total_rows=$(wc -l < "$table_name.table")
        
        # Check for empty tables
        if [ "$total_rows" -eq 0 ]; then
            echo "The table $table_name is empty. No rows to delete."
            continue
        fi
        if [ "$row_number" -gt "$total_rows" ]; then
            echo "Row number $row_number is out of range. The table has $total_rows rows."
            continue
        fi

        # Prevent deletion of rows 1 or 2
        if [ "$row_number" -eq 1 ] || [ "$row_number" -eq 2 ]; then
            echo "Rows 1 and 2 cannot be deleted. These rows might be critical or reserved."
            continue
        fi

        # Preview the row to delete
        echo "Preview of row to delete:"
        sed -n "${row_number}p" "$table_name.table"
        
        # Confirm deletion
        while true; do
            echo "Are you sure you want to delete row $row_number? (yes/no)"
            read confirmation
            
            if echo "$confirmation" | grep -iq "^yes$"; then
                # Delete the specified row
                sed -i "${row_number}d" "$table_name.table"
                echo "Row $row_number has been deleted from $table_name."
                echo "$(date): Deleted row $row_number from $table_name" >> delete_log.txt
                break
            elif echo "$confirmation" | grep -iq "^no$"; then
                echo "Deletion canceled."
                break
            else
                echo "Invalid response. Please enter 'yes' or 'no'."
            fi
        done

        break
    done
}
