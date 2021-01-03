"""Module containing classes for a simple banking system.

Auxiliary functions:
    is_valid_account_type(account_type)
    parse_ssn(ssn)
    class_account_type(class_name)

Classes:
    Account
    BankAccount(Account)
    CheckingAccount(BankAccount)
    SavingsAccount(BankAccount)
    CreditCardAccount(Account)
    Customer
    BankSystem

Auxiliary class:
    ComplexEncoder
"""

from datetime import date
import random
from email.utils import parseaddr
import credit_card_numbers_generator as cc_num_gen
import json


def is_valid_account_type(account_type):
    """Check if account_type is in the list of allowed account types."""
    if account_type.lower() not in {'checking', 'savings', 'credit'}:
        return False
    return True


def parse_ssn(ssn):
    """Check if ssn with '-' removed is a 9-digit number."""
    ssn_num = ssn.replace('-', '')
    if not ssn_num.isdigit() or len(ssn_num) != 9:
        return False
    return True


def class_account_type(class_name):
    """
    Return account type based on class name using the following map:

    Account -> account
    BankAccount -> bank
    CheckingAccount -> checking
    SavingsAccount -> savings
    CreditCardAccount -> credit
    """
    class_name = class_name.lower()
    if class_name != 'account':
        return class_name.replace('account', '').replace('card', '')
    else:
        return class_name


class Account:
    """
    A class to represent an account.

    Attributes
    ----------
    account_number : str
        Account number which consists of 6 to 17 digits and is unique for each account.
    is_active : bool
        Account status indicator (True for active, False for inactive accounts).
    date_opened : string
        The date when account was created in mm/dd/yyyy format.

    Properties
    ----------
    balance : float (read only)
        Return account balance.
    account_type : str (read only)
        Return account type.

    Methods
    -------
    balance_update(amount):
        Increase account balance by specified amount.

    deactivate():
        Set account status indicator to inactive.

    from_dict(dict):
        An alternative constructor. Initialize the attributes of the class from a dict.

    repr_json():
        Return dict representation of a class object.
    """

    def __init__(self):
        """
        Construct all the necessary attributes for the account object.

        Class attributes are initialized with the default values:
        account_number :
            A random string which consists of 6 to 17 digits.
        is_active :
            True
        date_opened :
            Today's date.
        _balance:
            0
        _account_type:
            The result of class_account_type(class_name) function.
        """
        self.account_number = str(
            random.randint(100000, 99999999999999999))  # US bank accounts can be from 6 to 17 digits
        self.is_active = True
        self.date_opened = date.today().strftime('%m/%d/%Y')
        self._balance = 0
        self._account_type = class_account_type(type(self).__name__)

    @property
    def balance(self):
        """Return account balance."""
        return self._balance

    @property
    def account_type(self):
        """Return account type."""
        return self._account_type

    def balance_update(self, amount):
        self._balance += amount

    def deactivate(self):
        self.is_active = False

    @classmethod
    def from_dict(cls, dict):
        """
        Initialize the attributes of the class from a dict.

        Parameters
        ----------
        dict : dict
            Dictionary with 'account_number', 'is_active', 'date_opened', and 'balance' keys.

        Returns
        -------
            An object of Account class.
        """
        account = cls()
        account.account_number = dict['account_number']
        account.is_active = dict['is_active']
        account.date_opened = dict['date_opened']
        account._balance = dict['balance']
        account._account_type = dict['account_type']
        return account

    def repr_json(self):
        """
        Return dict representation of the object.

        'account_number' attribute is excluded. Class properties are included.

        Returns
        -------
            dict
        """
        dict = {'is_active': self.is_active,
                'date_opened': self.date_opened,
                'balance': self.balance,
                'account_type': self.account_type}
        return dict

    def __str__(self):
        """
        Returns string representation of the object.

        Returns
        -------
            str
        """
        res = ''.join((
            'Account number: {}\n'.format(self.account_number),
            'Account type: {}\n'.format(self.account_type),
            'Active: {}\n'.format(self.is_active),
            'Date Opened: {}\n'.format(self.date_opened),
            'Balance: {:.2f}'.format(self.balance)
        ))
        return res


class BankAccount(Account):
    def __init__(self, interest_rate=0):
        super().__init__()
        self.interest_rate = interest_rate

    def withdraw(self, amount):
        if amount <= 0:
            raise ValueError('Invalid withdrawal amount.')
        if amount > self.balance:
            raise ValueError('Insufficient account balance.')
        self.balance_update(-amount)

    def deposit(self, amount):
        if amount <= 0:
            raise ValueError('Invalid deposit amount.')
        self.balance_update(amount)

    @classmethod
    def from_dict(cls, dict):
        account = super().from_dict(dict)
        account.interest_rate = dict['interest_rate']
        return account

    def repr_json(self):
        dict = super().repr_json()
        dict['interest_rate'] = self.interest_rate
        return dict

    def __str__(self):
        res = super().__str__()
        res = ''.join((
            res,
            '\n',
            'Interest rate: {:.2f}'.format(self.interest_rate)
        ))
        return res


class CheckingAccount(BankAccount):
    def __init__(self, interest_rate=0):
        super().__init__(interest_rate)
        self.debit_card = str(cc_num_gen.credit_card_number(cc_num_gen.visaPrefixList, 16, 1)[0])

    @classmethod
    def from_dict(cls, dict):
        account = super().from_dict(dict)
        account.debit_card = dict['debit_card']

        return account

    def repr_json(self):
        dict = super().repr_json()
        dict['debit_card'] = self.debit_card
        return dict

    def __str__(self):
        res = super().__str__()
        res = ''.join((
            res,
            '\n',
            'Debit card: {}'.format(self.debit_card)
        ))
        return res


class SavingsAccount(BankAccount):
    def __init__(self, interest_rate=0, one_time_withdrawal_limit=0):
        super().__init__(interest_rate)
        self.one_time_withdrawal_limit = one_time_withdrawal_limit

    def withdraw(self, amount):
        if amount > self.one_time_withdrawal_limit:
            raise ValueError('Amount exceeds one-time withdrawal limit.')
        super().withdraw(amount)

    @classmethod
    def from_dict(cls, dict):
        account = super().from_dict(dict)
        account.one_time_withdrawal_limit = dict['one_time_withdrawal_limit']
        return account

    def repr_json(self):
        dict = super().repr_json()
        dict['one_time_withdrawal_limit'] = self.one_time_withdrawal_limit
        return dict

    def __str__(self):
        res = super().__str__()
        res = ''.join((
            res,
            '\n',
            'One-time withdrawal limit: {:.2f}'.format(self.one_time_withdrawal_limit)
        ))
        return res


class CreditCardAccount(Account):
    def __init__(self, credit_limit=0, apr=0):
        super().__init__()
        self.credit_limit = credit_limit
        self.apr = apr
        self.credit_card = str(cc_num_gen.credit_card_number(cc_num_gen.visaPrefixList, 16, 10)[0])

    @property
    def available_credit(self):
        return self.credit_limit - self._balance

    def charge(self, amount):
        if amount <= 0:
            raise ValueError('Invalid charge amount.')
        if amount > self.available_credit:
            raise ValueError('Insufficient available credit.')
        self.balance_update(amount)

    def make_payment(self, amount):
        if amount <= 0:
            raise ValueError('Invalid payment amount.')
        if amount > self.balance:
            raise ValueError('Payment amount exceeds card balance.')
        self.balance_update(-amount)

    def __str__(self):
        res = super().__str__()
        res = ''.join((
            res,
            '\n',
            'Credit limit: {:.2f}\n'.format(self.credit_limit),
            'Available credit: {:.2f}\n'.format(self.available_credit),
            'APR: {:.2f}\n'.format(self.apr),
            'Credit card: {}'.format(self.credit_card)
        ))
        return res

    @classmethod
    def from_dict(cls, dict):
        account = super().from_dict(dict)
        account.credit_limit = dict['credit_limit']
        account.apr = dict['apr']
        account.credit_card = dict['credit_card']

        return account

    def repr_json(self):
        dict = super().repr_json()
        dict['credit_limit'] = self.credit_limit
        dict['apr'] = self.apr
        dict['credit_card'] = self.credit_card
        return dict


class Customer:
    def __init__(self, id, name, email, ssn):
        self.id = id
        self.name = name
        self.email = email
        self.ssn = ssn
        self.is_active = True
        self.checking_accounts = []
        self.savings_accounts = []
        self.credit_card_accounts = []

    def deactivate(self):
        self.is_active = False

    def accounts(self, account_type=None):
        if not account_type:
            return self.checking_accounts + self.savings_accounts + self.credit_card_accounts

        account_type = account_type.lower()
        if not is_valid_account_type(account_type):
            raise ValueError('Invalid account type.')
        if account_type == 'checking':
            return self.checking_accounts
        if account_type == 'savings':
            return self.savings_accounts
        if account_type == 'credit':
            return self.credit_card_accounts

    @property
    def ssn(self):
        return self._ssn

    @ssn.setter
    def ssn(self, ssn):
        if not parse_ssn(ssn):
            raise ValueError('Invalid SSN.')
        self._ssn = ssn

    @property
    def email(self):
        return self._email

    @email.setter
    def email(self, email):
        if '@' not in parseaddr(email)[1]:
            raise ValueError('Invalid email.')
        self._email = email

    def add_account(self, account_number, account_type):
        if account_type == 'checking':
            self.checking_accounts.append(account_number)
            return
        if account_type == 'savings':
            self.savings_accounts.append(account_number)
            return
        if account_type == 'credit':
            self.credit_card_accounts.append(account_number)
            return
        else:
            raise ValueError('Not a valid account type.')

    @classmethod
    def from_dict(cls, dict):
        customer = cls(dict['id'], dict['name'], dict['email'], dict['ssn'])
        customer.is_active = dict['is_active']
        customer.checking_accounts = dict['checking_accounts']
        customer.savings_accounts = dict['savings_accounts']
        customer.credit_card_accounts = dict['credit_card_accounts']
        return customer

    def repr_json(self):
        dict = {'name': self.name,
                'email': self.email,
                'ssn': self.ssn,
                'is_active': self.is_active,
                'checking_accounts': self.checking_accounts,
                'savings_accounts': self.savings_accounts,
                'credit_card_accounts': self.credit_card_accounts}
        return dict

    def __str__(self):
        res = ''.join((
            'Id: {}\n'.format(self.id),
            'Name: {}\n'.format(self.name),
            'Email: {}\n'.format(self.email),
            'SSN: {}\n'.format(self.ssn),
            'Active: {}'.format(self.is_active)
        ))
        return res


class BankingSystem:
    def __init__(self):
        self.max_customer_id = 0
        self.customers = {}
        self.accounts = {}

    def init_from_json(self, filename):
        with open(filename, 'r') as f:
            bank_json = json.load(f)

        self.max_customer_id = bank_json['max_customer_id']

        for id in bank_json["customers"]:
            dict = bank_json["customers"][id]
            id_int = int(id)
            dict['id'] = id_int
            self.customers[id_int] = Customer.from_dict(dict)

        for account_number in bank_json["accounts"]:
            dict = bank_json["accounts"][account_number]
            dict['account_number'] = account_number
            account_type = dict["account_type"]
            if account_type == 'checking':
                self.accounts[account_number] = CheckingAccount.from_dict(dict)
            if account_type == 'savings':
                self.accounts[account_number] = SavingsAccount.from_dict(dict)
            if account_type == 'credit':
                self.accounts[account_number] = CreditCardAccount.from_dict(dict)

    def customer_list(self, customer_status=None):
        for customer in self.customers.values():
            if not customer_status or customer.is_active == customer_status:
                print(customer)
                print('*' * 20)

    def account_list(self, account_types=None):
        for account in self.accounts.values():
            if not account_types or account.account_type in account_types:
                print(account)
                print('*' * 20)

    def repr_json(self):
        dict = {'max_customer_id': self.max_customer_id,
                'customers': self.customers,
                'accounts': self.accounts}
        return dict

    def save_to_json(self, filename):
        with open(filename, 'w') as f:
            json.dump(self.repr_json(), f, cls=ComplexEncoder, indent=2)


class ComplexEncoder(json.JSONEncoder):
    def default(self, obj):
        if hasattr(obj, 'repr_json'):
            return obj.repr_json()
        else:
            return json.JSONEncoder.default(self, obj)
