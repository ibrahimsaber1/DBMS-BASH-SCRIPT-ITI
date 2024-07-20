#!/bin/bash

drop_table() {
    echo "Drop Table"
    echo "Available tables:"
    ls *.table 2>/dev/null
    
    # Check if there are no tables available
    if [ $? -ne 0 ]; then
        echo "No tables found."
        return
    fi

    echo "Enter the table name to drop:"
    read table_name

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
        else
            echo "Table drop canceled."
        fi
    else
        echo "Table $table_name does not exist."
    fi


# Call the function
drop_table


}
