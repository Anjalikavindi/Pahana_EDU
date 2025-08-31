# Pahana Edu Online Billing System

A robust and secure web-based billing system designed to streamline day-to-day business operations. This application provides a comprehensive solution for managing employees, customers, inventory, and sales transactions in a retail environment.

## ✨ Features
### Secure Authentication & Authorization:

- A Java servlet filter to enhance the security of the application. 
- Role-based access control with distinct roles (e.g., Admin, Cashier, Inventory Manager).
- Admins can securely manage all user accounts.
- Admins have access to change the activity status of the users to control access of the users to the system.
- Session-based authentication to maintain user state.

### Employee/User Management:

<img width="1920" height="1301" alt="6" src="https://github.com/user-attachments/assets/ee983853-ca67-415b-9814-ac8e7e9359df" />

- Add, update, view, search and delete employee records.
- Set and manage user roles and account statuses.
- Secure password hashing to protect user credentials.

### Customer Management:

<img width="1920" height="1998" alt="4" src="https://github.com/user-attachments/assets/3f91cee4-cea3-4781-b262-7062dc06ddb2" />

- CRUD (Create, Read, Update, Delete) operations for customer records.
- View detailed customer information, including loyalty points in real-time.
- Filter customers

### Inventory Control:

<img width="1920" height="1657" alt="5" src="https://github.com/user-attachments/assets/f082186d-08b8-475f-afed-fdbc1eb5bbb5" />

- Add and manage product items, including stock levels.
- Automated stock reduction upon sale.
- Handles item creation, deletion, view and updates.
- Filter items

### Billing & Sales Transactions:

<img width="1920" height="1186" alt="3" src="https://github.com/user-attachments/assets/ac09a0f6-75c1-4f53-9822-8e770d3486da" />

- Generate a new bill with multiple items in a single transaction.
- Loyalty Program: Customers can use and earn loyalty points on each purchase.
- Dynamically calculate subtotals, grand totals, and change.

### Loyalty Program:

- Points Earning: Customers earn loyalty points based on their spending, with one point awarded for every Rs. 100 spent.
- Points Redemption: Customers can use their accumulated loyalty points during a transaction to receive a discount, which is automatically deducted from the grand total.
- Real-time Tracking: Customer loyalty points are automatically updated and tracked in the database after each transaction, ensuring an accurate and seamless experience.

### Automated Invoicing:

- Generates a professional PDF invoice for each transaction.

<img width="1920" height="912" alt="screencapture-file-C-Users-anjal-Downloads-bill-200063103588-3-pdf-2025-08-31-22_04_16" src="https://github.com/user-attachments/assets/11a6acab-ffb3-490b-b17f-6053fd36b3aa" />

- Automatically sends a detailed HTML invoice to the customer's email.

<img width="1920" height="1450" alt="screencapture-mail-google-mail-u-2-2025-08-31-22_06_35" src="https://github.com/user-attachments/assets/795a120d-418f-409d-8d2d-94e34b040782" />

### Help Section:

This page describe the functionality of different parts of the application.

<img width="1920" height="912" alt="7" src="https://github.com/user-attachments/assets/1535d2c4-1dfb-4f83-9889-2d9946451e3d" />


## 🚀 Core Operations

The application is built on a modular, MVC architecture that handles a wide range of operations.

### User Actions:

- Login: Users authenticate with their credentials.
- Logout: Ends the user session securely.
- Manage Employees: Admins can add new users, update details of the existing ones, activate/deactivate accounts and delete accounts.

### Customer Actions:

- Create Customer: Adds a new customer record. The system also logs the username of the logged-in user who performed the action, using session data. 

<img width="1920" height="910" alt="8" src="https://github.com/user-attachments/assets/c8008f99-1d1c-4e32-b1fa-fa6c37cea457" />

- Update Customer: Update the details of an existing customer

<img width="1920" height="909" alt="10" src="https://github.com/user-attachments/assets/e356639c-b1b4-4898-baa2-934d3e4930b4" />

- View Customer: Provides a customer view modal that retrieves and displays a complete profile from the database, including the registration date and the employee who created the record.  

<img width="1920" height="907" alt="9" src="https://github.com/user-attachments/assets/7cb4abc4-17cd-48be-b963-c9bbe54385cc" />

- Delete Customer: Removes a customer from the database.

<img width="1920" height="914" alt="v2" src="https://github.com/user-attachments/assets/39114393-af03-4d33-a13f-89dbbaecdedd" />


### Inventory Actions:

- Create Item: A new item is added to the inventory database, capturing details like price and quantity. The system also logs the username of the logged-in user who performed the action, using session data, ensuring accountability.

<img width="1920" height="909" alt="11" src="https://github.com/user-attachments/assets/ced0b719-7094-41b7-a06a-5935f6cc0ddb" />

- Update Item: Update the details of the selected item.

<img width="1920" height="910" alt="13" src="https://github.com/user-attachments/assets/f28e3238-35e9-4c7e-9ff6-7f5dafb20301" />

- View Item: The system provides a view item modal that retrieves a complete item profile from the database, which includes not only the item's details but also the date it was added and the user responsible for the entry

<img width="1920" height="909" alt="12" src="https://github.com/user-attachments/assets/5e581a3a-8446-4733-9fa3-4898067f90ba" />

- Delete Item: Removes a product from the inventory.

<img width="1920" height="910" alt="ival" src="https://github.com/user-attachments/assets/df142793-98d8-47e9-ac13-83b3c2154621" />


### Billing Actions:

- Bill Generation: Creates a new sales record, updates stock, and processes loyalty points.
- PDF & Email Invoicing: Generates and delivers digital invoices to the customer.

## 🎨 Design Patterns & Architecture

This project is built following established software design patterns to ensure maintainability, scalability, and security.

### Model-View-Controller (MVC) 

The application clearly separates its concerns:

- Model: The DAO (Data Access Object) classes and Bean classes handle data access and business logic.
- View: The JSP pages are responsible for the user interface.
- Controller: The Servlet classes manage user requests and orchestrate the flow between the Model and View.

### Data Access Object (DAO)

This pattern is used to abstract and centralize all database interactions. Each data entity (e.g., User, Customer, Item) has a corresponding DAO class that handles all CRUD operations, decoupling the business logic from the persistence layer.

### Singleton

The DBConnection.java utility class uses a static method getConnection() to provide a single, consistent point of access to the database connection. The database properties are loaded only once in the static initializer block.

## 🗃️ Database Schema
This project uses a MySQL database to manage its data. The schema, named pahana_edu, is comprised of six tables: users and roles to handle authentication and authorization; customers and items for managing core retail entities; and bills and bill_items to record transactional data. The tables are carefully structured with foreign key relationships to maintain data integrity across the application.

<img width="358" height="534" alt="db" src="https://github.com/user-attachments/assets/3ce2e887-5f8c-40c0-93be-0668556cf392" />



