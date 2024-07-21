#!/bin/bash

update_table() {
    echo -e "\nUpdate Table\n"
    read -p "Please enter table name: " tname

    # Check if table file exists
    if [ ! -f "$tname.table" ]; then
        echo -e "\nTable $tname not found!"
        return
    fi

    # Display the current data in the table
    echo -e "\nCurrent data in $tname:"
    sed '1d' "$tname.table" | awk -F: '{print $0}'

    # Prompt for primary key to update
    read -p "Enter the primary key value of the row you want to update: " pk

    # Check if primary key exists
    row=$(grep "^$pk:" "$tname.table")
    if [ -z "$row" ]; then
        echo -e "\nPrimary key $pk not found!"
        return
    fi

    # Extract current row data
    IFS=':' read -r -a fields <<< "$row"

    # Check if metadata file exists
    if [ ! -f "metaData_$tname" ]; then
        echo -e "\nMetadata file for table $tname does not exist."
        return
    fi

    # Read column definitions from metadata
    schema=$(awk -F' : ' 'NR>2 {print $3" "$4}' "metaData_$tname")
    IFS=$'\n' read -rd '' -a columns <<< "$schema"

    # Update each column
    for (( i=1; i<${#columns[@]}; i++ )); do
        IFS=' ' read -r col_name col_type <<< "${columns[$i]}"
        current_value="${fields[$i]}"
        
        # Prompt user for new value
        while true; do
            read -p "Set value of $col_name (current: $current_value, enter to keep): " new_value

            # If new_value is empty, keep current value
            if [ -z "$new_value" ]; then
                break
            fi

            # Validate based on data type
            case $col_type in
                int)
                    if ! [[ "$new_value" =~ ^[0-9]+$ ]]; then
                        echo -e "\nInvalid value for $col_name. Expected integer."
                        continue
                    fi
                    ;;
                str)
                    if ! [[ "$new_value" =~ ^[a-zA-Z0-9_]+$ ]]; then
                        echo -e "\nInvalid value for $col_name. Expected string."
                        continue
                    fi
                    ;;
                *)
                    echo -e "\nUnknown data type $col_type for $col_name."
                    return
                    ;;
            esac

            # Update value in fields array
            fields[$i]="$new_value"
            break
        done
    done

    # Rebuild the row with updated values
    updated_row=$(IFS=:; echo "${fields[*]}")

    # Remove the old row and add the updated row
    awk -v pk="$pk" -F: '$1 != pk' "$tname.table" > temp_file
    echo "$updated_row" >> temp_file
    mv temp_file "$tname.table"

    echo -e "\nRow updated successfully."

    # Display the updated data
    echo -e "\nUpdated data in $tname:"
    sed '1d' "$tname.table" | awk -F: '{print $0}'
}
