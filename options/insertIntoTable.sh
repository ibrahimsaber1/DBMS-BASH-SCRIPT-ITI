#!/bin/bash

insert_into_table() {
    echo -e "\nInsert into Table\n"
    read -r -p "Enter the table name to insert into: " table_name
    
    # Trim leading/trailing spaces
    table_name=$(echo "$table_name" | xargs)
    
    # Check if the table name is empty
    if [ -z "$table_name" ]; then
        echo -e "\nTable name cannot be empty."
        return
    fi
    
    # Check if the table exists
    if [ ! -f "$table_name.table" ]; then
        echo -e "\nTable $table_name does not exist."
        return
    fi
    
    # Read the schema from the metadata file
    if [ ! -f "metaData_$table_name" ]; then
        echo -e "\nMetadata file for table $table_name does not exist."
        return
    fi
    
    # Extract column definitions from metadata
    schema=$(awk -F' : ' 'NR>2 {print $3" "$4}' "metaData_$table_name")
    IFS=$'\n' read -rd '' -a columns <<< "$schema"
    
    # Read the current data from the table file
    data_lines=$(tail -n +2 "$table_name.table")
    
    # Create an array to store the new data
    new_data=()
    
    # Iterate over the columns to get input and validate
    for i in "${!columns[@]}"; do
        col=${columns[$i]}
        IFS=' ' read -r col_name col_type <<< "$col"
        
        while true; do
            # Prompt the user to enter the value for the column
            read -r -p "Enter value for $col_name ($col_type): " value
            value=$(echo "$value" | xargs)  # Trim leading/trailing spaces
            
            # Validate data type
            case $col_type in
                int)
                    if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                        echo -e "\nInvalid value for $col_name. Expected integer."
                        continue
                    fi
                    ;;
                str)
                    value=$(echo "$value" | tr ' ' '_')
                    if ! [[ "$value" =~ ^[a-zA-Z_]+$ ]]; then
                        echo -e "\nInvalid value for $col_name. Expected string."
                        continue
                    fi
                    ;;
                bool)
                    if ! [[ "$value" =~ ^(true|false)$ ]]; then
                        echo -e "\nInvalid value for $col_name. Expected boolean (true or false)."
                        continue
                    fi
                    ;;
                *)
                    echo -e "\nUnknown data type $col_type for $col_name."
                    return
                    ;;
            esac
            
            # Check if the column is a primary key and ensure it's unique
            if [ $i -eq 0 ]; then
                # This is the primary key column
                duplicate=false
                while IFS= read -r line; do
                    existing_value=$(echo "$line" | cut -d':' -f1)
                    if [ "$existing_value" == "$value" ]; then
                        echo -e "\nDuplicate primary key value for $col_name."
                        duplicate=true
                        break
                    fi
                done <<< "$data_lines"
                if [ "$duplicate" == true ]; then
                    continue
                fi
            fi
            
            # Append the value to the new data array
            new_data+=("$value")
            break
        done
    done
    
    # Join the new data array into a colon-separated string
    new_data_str=$(IFS=: ; echo "${new_data[*]}")
    
    # Add the new data to the table file
    echo "$new_data_str" >> "$table_name.table"
    echo -e "\nData has been inserted into $table_name."
}
