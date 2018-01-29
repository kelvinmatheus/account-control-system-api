# Project description

## Technical requirements

* The project must be developed in Ruby;
* The database must be SQL Server or MySQL;
* Layered development with efficient error handling;
* Create the necessary database resources (tables, indexes, etc). Take into account performance and scalability;
* The Backend must provide a Rest API;

## Expected Delivery

The complete solution (database scripts and any other artifacts needed to run the solution) should be made available in a public GitHub repository (http://github.com/).

## Evaluation

Its programming logic, project structuring, code quality and solution to the proposed problem will be evaluated. Do the best!

** Watch for web searches! ** Because it is a distance test, you will have free research, but explanations about the code may be requested by phone or in person.

## Need to be solved: Account control system

You must create a CRUD for Balance Account Maintenance. We can have 2 types of accounts:

* Master Account - It is the main account, which can have child accounts and these can also have their daughters, thus forming a hierarchy. It is the main account of the structure.

* Subsidiary Accounts - This is an account that is identical to the Parent Account, but it must have a Parent account (it can be the Parent Account or another Subsidiary Account) and may or may not have a Subsidiary Account below.

### Data for the Account Registration

```
Name
Birthdate
```

Note: Every Account must have a Person and this can be Legal or Juridical

### Information for the Legal Person

```
CPF
Full Name
Birthdate
```

### Information for the Juridical person

```
CNPJ (National Register of Legal Entities)
Company Name
Fantasy Name
```

## Transfer Functionality

Each Subsidiary Account can make transfers since the account that will receive the transfer is under the same tree and is not a Matrix account.

The Master Account can not receive transfers from other accounts, only Contributions that must have a unique alphanumeric code.

All transactions can be reversed (in case of a refund of a Contribution it is necessary to inform the alphanumeric code so that the transaction can be reversed).

Only Active Accounts can receive Charges or Transfers.


### Transactions Types

charge - deposit money in an account.

transfer - withdraw money from an account and deposit it to another.

reversal - transactions can be reversed (in case of a refund of a Contribution it is necessary to inform the alphanumeric code so that the transaction can be reversed).

## Account situation

* Any Account may be actived, blocked or canceled;

  **Actived** - when an account is actived, it is possible to do transactions with it.
  
  **Blocked** - when an account is blocked, it is not possible to do any kind of transaction. This account can be activated to continue to do transactions with it.
  
  **Canceled** - when an account is canceled, it is not possible to do any kind of transaction. This account cannot be activated or blocked. Additionally, it is necessary to withdraw all money before cancel an account.


* All Transaction history must be stored and queried.


## Glossary of terms

### Bank Terms

Debit - amount of money which was decreased/withdrawn from a specific account.
Credit - amount of money which was increased/saved to a specific account. It is also known as deposit.

Contribution - Entry of values (deposit/credit) ​​directly into the Matrix Account, through any transaction.

Transfer - Amounts of money moved between accounts, where one is debited and the other is credited.

### Type of transactions

...

### Person and Company terms

#### Legal person

**Legal person** is every human being as an individual, from birth to death. This designation is a legal concept and refers specifically to the individual as a subject that holds rights and duties. **Legal person** has a document that presents you. It is called CPF.

**CPF (Individual Taxpayer Registration Number)** is a number compose of 11 numbers which represent a person. It is unique. It has a rule that says how it has to be created.


#### Juridical person

**Juridical person** or **Legal entity** is an entity constituted by a person and recognized by the State as having rights and duties. The term may refer to companies, governments, organizations or any group created for a specific purpose. This juridical person has a document to represent it. It is called **CNPJ**. It also has to have a **Company name** and a **Fantasy name**.

**CNPJ (National Register of Legal Entities)** - It is a number compose of 14 numbers  which represent a Company. It is unique. It has a rule that says how it has to be created.

**Company Name** is the business name of your company. Also known as Commercial Name, Corporate Name or Business Firm is the name given to the legal entity, which appears in legal documents, contracts and deeds. In addition to representing the birth of a company.

**Fantasy Name** is the business or popular name of the company, which may be the same or an abbreviation of the company name, but may also be completely different.


