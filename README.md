# Bash Shell Script Database Management System (DBMS)

## Project Overview

This project aims to develop a simple Database Management System (DBMS) using Bash shell scripting. The system allows users to store and retrieve data from the hard disk through a Command-Line Interface (CLI) menu-based application.

## Features

### Main Menu
- **Create Database**: Create a new database (stored as a directory).
- **List Databases**: List all existing databases.
- **Connect To Database**: Connect to a specific database to perform operations.
- **Drop Database**: Delete a specified database.

### Database Operations (After Connecting to a Database)
- **Create Table**: Create a new table within the connected database.
- **List Tables**: List all tables within the connected database.
- **Drop Table**: Delete a specified table from the connected database.
- **Insert into Table**: Insert a new row of data into a specified table.
- **Select From Table**: Retrieve and display data from a specified table.
- **Delete From Table**: Delete specific rows from a specified table.
- **Update Table**: Update data in a specified table.

## Usage

### Main Menu

1. **Create Database**
   - Enter the database name.
   - The system will create a directory for the database if it does not already exist.

2. **List Databases**
   - Lists all existing databases (directories).

3. **Connect To Database**
   - Enter the database name to connect.
   - Upon successful connection, a new menu for database operations is displayed.

4. **Drop Database**
   - Enter the database name to delete.
   - The system will prompt for confirmation before deleting the database.

### Database Operations Menu

1. **Create Table**
   - Enter the table name and the number of columns.
   - Define column names and data types (int or str).
   - The first column is the primary key (int).

2. **List Tables**
   - Lists all tables (files) in the connected database.

3. **Drop Table**
   - Enter the table name to delete.
   - The system will prompt for confirmation before deleting the table.

4. **Insert into Table**
   - Enter the table name.
   - Input values for each column. The system validates data types and enforces primary key uniqueness.

5. **Select From Table**
   - Choose to display the entire table or specific rows based on column values.

6. **Delete From Table**
   - Enter the table name and row number to delete.
   - The system will prompt for confirmation before deleting the row.

7. **Update Table**
   - Enter the table name and primary key value of the row to update.
   - Input new values for the columns. The system validates data types.

## Implementation Details

- Databases are stored as directories in the current script directory.
- Tables are stored as files with the `.table` extension.
- Metadata files (e.g., `metaData_<table_name>`) store schema information for each table.
- Primary key constraints and data type checks are enforced during data insertion and updates.
- Log files track operations like deletions for auditing purposes.

## How to Clone the Repository

1. Ensure you have Git installed on your system.
2. Open a terminal and navigate to the directory where you want to clone the repository.
3. Run the following command:
   ```bash
   git clone <repository-url>
   ```
4. Navigate to the project directory:
   ```bash
   cd <repository-name>
   ```

## How to Run

1. Ensure you have Bash installed on your system.
2. Make the main script executable:
   ```bash
   chmod +x main.sh
   ```
3. Run the script:
   ```bash
   ./main.sh
   ```

## Script Breakdown

- **main.sh**: The main script that displays the main menu and handles user input for database operations.
- **createDatabase.sh**: Script to handle the creation of databases.
- **listDatabase.sh**: Script to list all existing databases.
- **connectToDatabase.sh**: Script to connect to a specific database and display the database operations menu.
- **dropDatabase.sh**: Script to delete a specified database.
- **createTable.sh**: Script to handle the creation of tables within a connected database.
- **listTable.sh**: Script to list all tables within a connected database.
- **dropTable.sh**: Script to delete a specified table from a connected database.
- **insertIntoTable.sh**: Script to insert data into a specified table.
- **selectFromTable.sh**: Script to retrieve and display data from a specified table.
- **deleteFromTable.sh**: Script to delete specific rows from a specified table.
- **updateTable.sh**: Script to update data in a specified table.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This project is licensed under the MIT License.

## Authors

This project was made by two ITI students:
- Ibrahim Saber
- David Emad
