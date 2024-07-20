#!/bin/bash

drop_table() {
    while true; do
        echo "Drop Table"
        echo "Available tables:"
        
        # Check if there are tables available
        tables=$(ls *.table 2>/dev/null)
        if [ -z "$tables" ]; then
            echo "No tables found."
            return
        fi
        
        echo "$tables"
        
        echo "Enter the table name to drop (or type 'exit' to cancel):"
        read table_name

        if [ "$table_name" == "exit" ]; then
            echo "Table drop canceled."
            return
        fi
        
        if [ -z "$table_name" ]; then
            echo "Table name cannot be empty."
            continue
        fi
        
        if [ -f "$table_name.table" ]; then
            # Display the table's content for the user to review
            echo "Current data in $table_name:"
            cat "$table_name.table"
            
            # Confirm deletion
            echo "Are you sure you want to drop the table $table_name? (yes/no)"
            read confirmation
            
            if [ "$confirmation" == "yes" ]; then
                # Drop the table
                rm "$table_name.table"
                echo "Table $table_name has been dropped."
                return
            else
                echo "Table drop canceled."
                return
            fi
        else
            echo "Table $table_name does not exist."
        fi
    done
}

# Call the function
drop_table
