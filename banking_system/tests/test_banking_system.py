"""Unit tests for banking_system module.
"""
import banking_system as b
import pytest
from datetime import date


@pytest.fixture
def account():
    account = b.Account()
    return account


def test_account(account):
    assert account.account_number
    assert account.is_active
    assert account.date_opened == date.today().strftime('%m/%d/%Y')
    assert account.balance == 0
    assert account.account_type == 'account'


def test_account_from_dict():
    dict = {'account_number': '39115617804224013',
            'is_active': False,
            'date_opened': '12/28/2020',
            'balance': 950,
            'account_type': 'account'}
    account = b.Account.from_dict(dict)
    assert account.account_number == '39115617804224013'
    assert account.is_active == False
    assert account.date_opened == '12/28/2020'
    assert account.balance == 950
    assert account.account_type == 'account'


def test_account_balance(account):
    account.balance_update(100)
    account.balance_update(-50)
    account.balance_update(200)
    assert account.balance == 250


def test_account_deactivate(account):
    account.deactivate()
    assert not account.is_active


@pytest.mark.parametrize('param, res',
                         [
                             ('123456789', True),
                             ('123-45-6789', True),
                             ('12345678', False),
                             ('1234567890', False),
                             ('12345678a', False),
                             ('123_45_6789', False),
                         ])
def test_parse_ssn(param, res):
    assert b.parse_ssn(param) == res


@pytest.mark.parametrize('param, res',
                         [
                             ('checking', True),
                             ('savings', True),
                             ('credit', True),
                             ('checking'.upper(), True),
                             ('savings'.upper(), True),
                             ('credit'.upper(), True),
                             ('money_market', False),
                         ])
def test_is_valid_account_type(param, res):
    assert b.is_valid_account_type(param) == res
