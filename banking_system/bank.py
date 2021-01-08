"""Command line interface for a simple banking system.

   Read README.md for usage information.
"""
from banking_system import *
import logging

source_file_name = 'bank.json'
log_file_name = 'bank.log'

# Configuring loggers
log_banking_system = logging.getLogger("banking_system")
"""
A child logger with a different level to easily toggle on and off
logging of informational messages for the actions which only retrieve data. 
"""
log_banking_system_show = log_banking_system.getChild("show")

log_banking_system.setLevel(logging.INFO)
log_banking_system_show.setLevel(logging.ERROR)

fileHandler = logging.FileHandler(log_file_name)
formatter = logging.Formatter('%(asctime)s %(levelname)8s %(name)s | %(message)s',
                              "%Y-%m-%d %H:%M:%S")
fileHandler.setFormatter(formatter)

log_banking_system.addHandler(fileHandler)
log_banking_system_show.addHandler(fileHandler)

# To avoid duplicated records in the log
log_banking_system_show.propagate = False


def main():
    try:
        banking_system = BankingSystem()

        try:
            banking_system.init_from_json(source_file_name)
        except Exception as e:
            msg = str(e)
            print(msg)
            log_banking_system.warning(msg)

        while True:
            print()
            print('''Please choose an option: 
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
            12. Exit
            ''')
            mm = input('Option #: ')

            if not mm.isdigit() or int(mm) not in range(1, 13):
                print('Invalid option. Please try again.')
                continue
            else:
                mm = int(mm)

                # 1. Add customer
                if mm == 1:
                    customer_info = input('Enter customer name, email, and SSN comma separated: ')
                    if customer_info == 'exit':
                        continue

                    try:
                        name, email, ssn = [s.strip() for s in customer_info.split(',')]
                    except Exception:
                        print('Invalid entry.')
                        continue

                    try:
                        key = banking_system.max_customer_id + 1
                        customer = Customer(key, name, email, ssn)
                        banking_system.customers[key] = customer
                        banking_system.max_customer_id = key
                    except Exception as e:
                        print(e)
                        continue

                    msg = 'Customer {} ({}) added.'.format(customer.name, customer.id)
                    print(msg)
                    log_banking_system.info(msg)

                # 2. Add account
                if mm == 2:
                    account_info = input('''Enter account info in the following format:
                    Checking: checking, <optional interest rate>
                    Savings:  savings, <optional interest rate>, <optional one_time_withdrawal_limit>
                    Credit card: credit, <credit_limit>, <apr>
                    ''')
                    if account_info == 'exit':
                        continue

                    args = [a.strip() for a in account_info.split(',')]
                    account_type = args[0]
                    if not is_valid_account_type(account_type):
                        print('Invalid account type.')
                        continue
                    else:
                        if account_type == 'checking':
                            interest_rate = None
                            if len(args) > 1:
                                try:
                                    interest_rate = float(args[1])
                                except Exception:
                                    print('Interest rate should be a float.')
                                    continue
                            try:
                                account = CheckingAccount(interest_rate)
                                key = account.account_number
                                banking_system.accounts[key] = account
                            except Exception as e:
                                print(e)
                                continue
                        if account_type == 'savings':
                            interest_rate = None
                            one_time_withdrawal_limit = 0
                            if len(args) > 1:
                                try:
                                    interest_rate = float(args[1])
                                except Exception:
                                    print('Interest rate should be a float.')
                                    continue
                            if len(args) > 2:
                                try:
                                    one_time_withdrawal_limit = float(args[2])
                                except Exception:
                                    print('One time withdrawal limit should be a float.')
                                    continue
                            try:
                                account = SavingsAccount(interest_rate, one_time_withdrawal_limit)
                                key = account.account_number
                                banking_system.accounts[key] = account
                            except Exception as e:
                                print(e)
                                continue
                        if account_type == 'credit':
                            if len(args) < 3:
                                print('Insufficient number of arguments provided.')
                                continue
                            else:
                                try:
                                    credit_limit = float(args[1])
                                    apr = float(args[2])
                                except Exception:
                                    print('Credit limit and APR should be floats.')
                                    continue
                            try:
                                account = CreditCardAccount(credit_limit, apr)
                                key = account.account_number
                                banking_system.accounts[key] = account
                            except Exception as e:
                                print(e)
                                continue

                    msg = 'Account {} ({}) added.'.format(account.account_number, account.account_type)
                    print(msg)
                    log_banking_system.info(msg)

                # 3. Add account to customer
                if mm == 3:
                    s = input('Please enter customer id and account number comma separated: ')
                    if s == 'exit':
                        continue

                    try:
                        customer_id, account_number = [arg.strip() for arg in s.split(',')]
                    except Exception:
                        print('Invalid number of arguments.')
                        continue

                    customer_id = int(customer_id)
                    if customer_id not in banking_system.customers:
                        print("Customer id doesn't exist.")
                        continue

                    if account_number not in banking_system.accounts:
                        print("Account number doesn't exist.")
                        continue

                    customer = banking_system.customers[customer_id]
                    account = banking_system.accounts[account_number]

                    customer.add_account(account_number, account.account_type)

                    msg = 'Account {} ({}) added to customer {} ({}).'.format(account_number, account.account_type,
                                                                              customer.name, customer_id)
                    print(msg)
                    log_banking_system.info(msg)

                # 4. Account list by customer
                if mm == 4:
                    customer_id = input('Please enter customer id: ')
                    if customer_id == 'exit':
                        continue

                    customer_id = int(customer_id)
                    if customer_id not in banking_system.customers:
                        print("Customer id doesn't exist.")
                        continue

                    customer = banking_system.customers[customer_id]

                    msg = 'Printing account list for customer id={}...'.format(customer_id)
                    print(msg)
                    log_banking_system_show.info(msg)
                    print('*' * 20)
                    for account_number in customer.accounts():
                        print(banking_system.accounts[account_number])
                        print('*' * 20)

                # 5. Customer list
                if mm == 5:
                    s = input('Enter 1 for active customers, 0 for inactive, or press Enter for all: ')
                    if s == 'exit':
                        continue

                    if s not in {'1', '0', ''}:
                        print('Invalid option.')
                        continue
                    status = bool(int(s)) if s else None

                    msg = 'Printing customer list...'
                    print(msg)
                    log_banking_system_show.info(msg)
                    print('*' * 20)
                    banking_system.customer_list(status)

                # 6. Account list
                if mm == 6:
                    s = input('Please list account type(s) (checking, savings, or credit) comma separated or press Enter '
                              'for all: ')
                    if s == 'exit':
                        continue

                    if s:
                        account_types = [a.strip().lower() for a in s.split(',')]
                    else:
                        account_types = []
                    if sum([int(not is_valid_account_type(a)) for a in account_types]) > 0:
                        print('Invalid account type(s).')
                        continue

                    msg = 'Printing account list...'
                    print(msg)
                    log_banking_system_show.info(msg)
                    print('*' * 20)
                    banking_system.account_list(account_types)

                # 7. Customer info
                if mm == 7:
                    customer_id = input('Please enter customer id: ')
                    if customer_id == 'exit':
                        continue

                    customer_id = int(customer_id)
                    if customer_id not in banking_system.customers:
                        print("Customer id doesn't exist.")
                        continue

                    customer = banking_system.customers[customer_id]

                    msg = 'Printing customer info for customer id={}...'.format(customer_id)
                    print(msg)
                    log_banking_system_show.info(msg)
                    print('*' * 20)
                    print(customer)

                # 8. Account info
                if mm == 8:
                    account_number = input('Please enter account number: ')
                    if account_number == 'exit':
                        continue

                    if account_number not in banking_system.accounts:
                        print("Account number doesn't exist.")
                        continue

                    account = banking_system.accounts[account_number]

                    msg = 'Printing account info for account {}...'.format(account_number)
                    print(msg)
                    log_banking_system_show.info(msg)
                    print('*' * 20)
                    print(account)

                # 9. Deactivate customer
                if mm == 9:
                    customer_id = input('Please enter customer id: ')
                    if customer_id == 'exit':
                        continue

                    customer_id = int(customer_id)
                    if customer_id not in banking_system.customers:
                        print("Customer id doesn't exist.")
                        continue

                    customer = banking_system.customers[customer_id]
                    customer.deactivate()

                    msg = 'Customer {} ({}) deactivated.'.format(customer.name, customer.id)
                    print(msg)
                    log_banking_system.info(msg)

                # 10. Close account
                if mm == 10:
                    account_number = input('Please enter account number: ')
                    if account_number == 'exit':
                        continue

                    if account_number not in banking_system.accounts:
                        print("Account number doesn't exist.")
                        continue

                    account = banking_system.accounts[account_number]
                    account.deactivate()

                    msg = 'Account {} closed.'.format(account.account_number)
                    print(msg)
                    log_banking_system.info(msg)

                # 11. Account transaction
                if mm == 11:
                    account_number = input('Please enter account number: ')
                    if account_number == 'exit':
                        continue

                    if account_number not in banking_system.accounts:
                        print("Account number doesn't exist.")
                        continue

                    account = banking_system.accounts[account_number]
                    account_type = account.account_type

                    operations = {'credit': ['charge', 'payment'],
                                  'checking': ['deposit', 'withdrawal'],
                                  'savings': ['deposit', 'withdrawal']}

                    operation = input(
                        f'Please enter 1 for {operations[account_type][0]}, 2 for {operations[account_type][1]}: ')
                    if operation not in {'1', '2'}:
                        print('Invalid operation.')
                        continue

                    amount = input('Please enter amount: ')
                    try:
                        amount_num = float(amount)
                    except Exception:
                        print('Amount should be a float.')
                        continue

                    try:
                        if operation == '1':
                            if account_type == 'credit':
                                account.charge(amount_num)
                            else:
                                account.deposit(amount_num)
                        else:
                            if account_type == 'credit':
                                account.make_payment(amount_num)
                            else:
                                account.withdraw(amount_num)
                    except Exception as e:
                        print(e)
                        continue

                    msg = 'Account {} transaction ({}) for {:.2f}.'.format(
                        account_number, operations[account_type][int(operation) - 1], amount_num)
                    print(msg)
                    log_banking_system.info(msg)

                # 12. Exit
                if mm == 12:
                    break

        try:
            banking_system.save_to_json(source_file_name)
        except Exception as e:
            msg = str(e) + '. ' + "Couldn't save changes to file."
            print(msg)
            log_banking_system.error(msg)

    except Exception as e:
        msg = str(e) + '. ' + 'Unhandled error. Program terminated.'
        print(msg)
        log_banking_system.critical(msg)


if __name__ == "__main__":
    main()
