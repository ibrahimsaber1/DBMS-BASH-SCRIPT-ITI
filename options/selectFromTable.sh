select_from_table() {
    echo -e "\nSelect From Table\n"
    read -p "Please enter table name: " tname

    # Trim leading/trailing spaces
    tname=$(echo "$tname" | xargs)
    
    # Check if table file exists
    if [ ! -f "$tname.table" ]; then
        echo -e "\nTable $tname not found!"
        return
    fi

    # Determine the number of columns in the table
    num_columns=$(head -n 1 "$tname.table" | awk -F: '{print NF}')

    # Ask user for selection type
    echo -e "\n1. Show entire table"
    echo "2. Select specific rows"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            # Display entire table
            echo -e "\nEntire data in $tname:"
            cat "$tname.table" | column -t -s ":"
            ;;
        2)
            while true; do
                read -p "Enter column number to search (starting from 1): " col_num

                # Validate column number
                if ! [[ "$col_num" =~ ^[0-9]+$ ]]; then
                    echo -e "\nInvalid column number. Please enter a valid number."
                elif (( col_num < 1 || col_num > num_columns )); then
                    echo -e "\nColumn number out of range. Please enter a number between 1 and $num_columns."
                else
                    break
                fi
            done

            while true; do
                read -p "Enter value to search for: " search_value

                # Perform the search and store the result
                search_result=$(awk -v col="$col_num" -v val="$search_value" -F: 'BEGIN {IGNORECASE=1} NR==1 {header=$0; next} $col ~ val' "$tname.table")

                if [ -z "$search_result" ]; then
                    echo -e "\nNo rows matching the search criteria."
                
                else
                    echo -e "\nRows matching search criteria:"
                    echo "$search_result" | column -t -s ":"
                    break
                fi
            done
            ;;
        *)
            echo -e "\nInvalid choice. Please try again."
            ;;

    esac
}
