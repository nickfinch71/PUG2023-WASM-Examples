
/*------------------------------------------------------------------------
    File        : GetCustomers.p
    Purpose     : 

    Syntax      :

    Description : Returns a dataset with all sports2000 customers

    Author(s)   : inmydata
    Created     : Wed Oct 06 18:27:44 UTC 2021
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */
DEFINE DATA-SOURCE srcCustomer FOR customer.
DEFINE TEMP-TABLE ttCustomer LIKE Customer.
DEFINE DATASET dsCustomer FOR ttCustomer.

DEFINE OUTPUT PARAMETER DATASET FOR dsCustomer.

/* ***************************  Main Block  *************************** */


BUFFER ttCustomer:ATTACH-DATA-SOURCE(DATA-SOURCE srcCustomer:HANDLE).
DATASET dsCustomer:FILL().
BUFFER ttcustomer:DETACH-DATA-SOURCE().

