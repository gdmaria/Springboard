# Bank.py
Bank.py is a Python program for a simple banking system.

### Version
1.0

## Project files:
bank.json  
**bank.py** 
banking_system.py
credit_card_numbers_generator.py
bank.log
README.md
docs/banking_system_class_diagram.jpg
tests/test_banking_system.py 

## Command line usage
\\> cd \<*path to bank.py*\>  
\\> python bank.py

## Main menu options:
1. Add customer
2. Add account
3. Add account to customer
4. Account list by customer 
5. Customer list
6. Account list
7. Customer info
8. Account info
9. Deactivate customer
10. Close account
11. Account transaction

## Instructions
* Follow on-screen prompts to navigate the menu and to enter required input data.
* Entering 'exit' from any sub-menu results in redirect to the main menu.
* Invalid data entries result in redirect to the main menu.

## Data storage
* Data is saved to **bank.json** file.
* When the program is started, banking system is initiated with data from **bank.json** file.
* If **bank.json** file is missing, a banking system with no data is created.
* **bank.json** file is overridden upon program termination with data representing current state of banking system.

## Logging
Program log is saved to **bank.log** file.

## Unit tests
**Prerequisites**: pytest. 

\\> cd \<*path to test_banking_system.py*\>  
\\> pytest test_banking_system.py

## Notes
* In version 1.0, docstrings are added only to Account class in the banking_system module.
* In version 1.0, unit tests are implemented only for Account class methods and module level functions in the banking_system module.

## Links
1. credit_card_numbers_generator.py - https://github.com/eye9poob/python/blob/master/credit-card-numbers-generator.py
2. UML diagram tool - https://www.visual-paradigm.com/