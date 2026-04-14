CLASS zcl_40_30_itab_arbeitbereich DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_30_itab_arbeitbereich IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Abbildung 134 1 Beispiel

  TYPES: BEGIN OF st_carrier,               " struktur erstellen
             carrier_id TYPE /dmo/carrier-carrier_id,
             currency_code  TYPE /dmo/carrier-currency_code,
           END OF st_carrier.

* Standard Tabelle auf Struktur erstellen
  DATA Carriers TYPE STANDARD TABLE OF st_carrier WITH NON-UNIQUE Key carrier_id.

* Arbeitsbereich erstellen
  DATA carrier LIKE LINE OF carriers.
* Struktur füllen
* 1 Beispiel
       carrier-carrier_id = 'AA'.
       carrier-currency_code = 'USD'.

  APPEND carrier TO carriers.

* oder mit VALUE
   carrier = VALUE #( carrier_id = 'LH'
                      currency_code = 'EUR' ).

  APPEND carrier TO carriers.

  carrier = VALUE #( carrier_id = 'JL'
                      currency_code = 'JPY' ).

  APPEND carrier TO carriers.

   LOOP AT carriers into carrier.

       carrier-currency_code = 'USD'.

     MODIFY carriers FROM carrier.    " Mit MODIFY bekommen alle Carrier USD


   ENDLOOP.

    out->write( carriers ).


  ENDMETHOD.

ENDCLASS.

