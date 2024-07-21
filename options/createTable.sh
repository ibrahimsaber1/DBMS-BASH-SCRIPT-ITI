#!/bin/bash

create_table () {
    echo -e "\nCreate Table\n"
    read -p "Please enter the name of the table: " table_name
    
    # Check if the table name is empty
    if [ -z "$table_name" ]; then
        echo -e "\nPlease enter a correct name\n"
        create_table # call the function again
    
    # Check if the table name contains spaces
    elif [[ "$table_name" = *[[:space:]]* ]]; then
        echo -e "\nTable name cannot contain spaces\n"
        create_table # call the function again
    
    # Check if the table already exists
    elif [ -f "./databases/$db_name/$table_name" ]; then
        echo -e "\nThis table name already exists\n"
        create_table # call the function again
    
    # Check if the table name starts with an alphabetic character
    elif [[ "$table_name" == [a-zA-Z]* ]]; then
        echo -e "\nTable created successfully\n"
        touch "./databases/$db_name/$table_name"
        
        read -p "Enter number of columns: " colnumber
        
        # Write metadata to the table file
        echo "general : Table Name : $table_name" > "./databases/$db_name/$table_name"
        echo "general : Number of Columns : $colnumber" >> "./databases/$db_name/$table_name"
        
        index=1
        while [ $index -le $colnumber ]; do
            if [ $index -eq 1 ]; then
                echo -e "===================================="
                echo -e "The first column is the primary key"
                echo -e "===================================="
                read -p "Enter column $index name: " colname
                echo "primary key : $index : $colname : int" >> "./databases/$db_name/$table_name"
                printf "$colname:" >> "./databases/$db_name/$table_name"
            else
                echo ""
                read -p "Enter column $index name: " colname
                echo ""
                echo -e "Type of column $colname: "
                select datatype in "int" "str"; do
                    case $datatype in
                        int ) colType="int"; break;;
                        str ) colType="string"; break;;
                        * ) echo -e "\nWrong Choice!!!";;
                    esac
                done
                echo "Not primary key : $index : $colname : $datatype" >> "./databases/$db_name/$table_name"
                printf "$colname:" >> "./databases/$db_name/$table_name"
            fi
            ((index = $index + 1))
        done
        printf "\n" >> "./databases/$db_name/$table_name"
        printf "=================\n" >> "./databases/$db_name/$table_name"
        echo -e "\nTable created successfully\n"
    else
        echo -e "\nPlease enter a correct name\n"
        create_table # call the function again
    fi
}
