#!/bin/bash

insert_into_table() {
    echo "Insert into Table"
    echo "Available tables:"
    ls *.table 2>/dev/null
    
    # Check if there are no tables available
    if [ $? -ne 0 ]; then
        echo "No tables found."
        return
    fi

    echo "Enter the table name to insert into:"
    read table_name

    if [ -f "$table_name.table" ]; then
        # Read the schema from the table file
        schema=$(head -n 1 "$table_name.table")
        IFS=',' read -r -a columns <<< "$schema"
        
        # Read the current data from the table file
        data_lines=$(tail -n +2 "$table_name.table")
        
        # Create an array to store the new data
        new_data=()
        
        # Iterate over the columns to get input and validate
        for col in "${columns[@]}"; do
            IFS=':' read -r col_name col_type col_pk <<< "$col"
            
            while true; do
                # Prompt the user to enter the value for the column
                read -p "Enter value for $col_name ($col_type): " value
                value=$(echo "$value" | xargs)  # Trim leading/trailing spaces

                # Validate data type
                case $col_type in
                    int)
                        if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                            echo "Invalid value for $col_name. Expected integer."
                            continue
                        fi
                        ;;
                    str)
                        if ! [[ "$value" =~ ^[a-zA-Z0-9_]+$ ]]; then
                            echo "Invalid value for $col_name. Expected string."
                            continue
                        fi
                        ;;
                    *)
                        echo "Unknown data type $col_type for $col_name."
                        return
                        ;;
                esac

                # Check if the column is a primary key and ensure it's unique
                if [ "$col_pk" == "pk" ]; then
                    duplicate=false
                    for line in $data_lines; do
                        existing_value=$(echo $line | cut -d',' -f$((${#new_data[@]} + 1)))
                        if [ "$existing_value" == "$value" ]; then
                            echo "Duplicate primary key value for $col_name."
                            duplicate=true
                            break
                        fi
                    done
                    if [ "$duplicate" == true ]; then
                        continue
                    fi
                fi
                
                # Append the value to the new data array
                new_data+=("$value")
                break
            done
        done
        
        # Join the new data array into a comma-separated string
        new_data_str=$(IFS=, ; echo "${new_data[*]}")
        
        # Add the new data to the table file
        echo "$new_data_str" >> "$table_name.table"
        echo "Data has been inserted into $table_name."
    else
        echo "Table $table_name does not exist."
    fi
}

# Call the function
insert_into_table
