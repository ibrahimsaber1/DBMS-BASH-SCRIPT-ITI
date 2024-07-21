#!/bin/bash

select_from_table() {
    echo -e "\nSelect From Table\n"
    read -p "Please enter table name: " tname

    # Check if table file exists
    if [ ! -f "$tname.table" ]; then
        echo -e "\nTable $tname not found!"
        return
    fi

    # Ask user for selection type
    echo -e "\n1. Show entire table"
    echo "2. Select specific rows"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            # Display entire table
            echo -e "\nEntire data in $tname:"
            cat "$tname.table"
            ;;
        2)
            # Select specific rows
            read -p "Enter column number to search (starting from 1): " col_num
            read -p "Enter value to search for: " search_value
            
            echo -e "\nRows matching search criteria:"
            awk -v col="$col_num" -v val="$search_value" -F: 'NR==1 || $col == val' "$tname.table"
            ;;
        *)
            echo -e "\nInvalid choice. Please try again."
            ;;
    esac
}
