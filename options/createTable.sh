#!/bin/bash

create_table() {
    echo -e "\nCreate Table\n"
    read -p "Please enter the name of the table(must start with alphabetic character): " table_name
    
    # Trim leading/trailing spaces
    table_name=$(echo "$table_name" | xargs)
    
    # Check if the table name is empty
    if [ -z "$table_name" ]; then
        echo -e "\nPlease enter a correct name, name can not be empty\n"
        create_table # call the function again

    # Check if the table name contains spaces
    elif [[ "$table_name" = *[[:space:]]* ]]; then
        echo -e "\nTable name cannot contain spaces\n"
        create_table # call the function again

    # Check if the table already exists
    elif [ -f "$table_name.table" ]; then
        echo -e "\nThis table name already exists\n"
        create_table # call the function again

    # Check if the table name starts with an alphabetic character
    elif [[ "$table_name" == [a-zA-Z]* ]]; then
        echo -e "\nTable created successfully\n"
        touch "$table_name.table"
        touch "metaData_$table_name"

        read -p "Enter number of columns: " colnumber
        
        # Write metadata to the metadata file
        echo "general : Table Name : $table_name" > "metaData_$table_name"
        echo "general : Number of Columns : $colnumber" >> "metaData_$table_name"
        
        index=1
        while [ $index -le $colnumber ]; do
            if [ $index -eq 1 ]; then
                echo -e "===================================="
                echo -e "The first column is the primary key and its data type is int by default"
                echo -e "===================================="
                read -p "Enter column $index name: " colname
                # Replace spaces with underscores in column name
                colname=$(echo "$colname" | tr ' ' '_')
                echo "primary key : $index : $colname : int" >> "metaData_$table_name"
                printf "$colname:" >> "$table_name.table"
            else
                echo ""
                read -p "Enter column $index name: " colname
                # Replace spaces with underscores in column name
                colname=$(echo "$colname" | tr ' ' '_')
                echo ""
                echo -e "Type of column $colname: "
                select datatype in "int" "str" "bool" ; do
                    case $datatype in
                        int ) colType="int"; break;;
                        str ) colType="str"; break;;
                        bool ) colType="bool"; break;;
                        * ) echo -e "\nWrong Choice!!!";;
                    esac
                done
                echo "Not primary key : $index : $colname : $colType" >> "metaData_$table_name"
                printf "$colname:" >> "$table_name.table"
            fi
            ((index = $index + 1))
        done
        printf "\n" >> "$table_name.table"
        printf "=================\n" >> "$table_name.table"
        echo -e "\nTable created successfully\n"
    else
        echo -e "\nPlease enter a correct name\n"
        create_table # call the function again
    fi
}
