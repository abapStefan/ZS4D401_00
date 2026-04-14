CLASS zcl_40_19_zeitstempel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_19_zeitstempel IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Manipulation von Zeistempeln

    DATA var_utc TYPE utclong.

    var_utc = utclong_current(  ).

    out->write( var_utc ).


    var_utc = utclong_add( val = var_utc days = 1 hours = +1 ).

     out->write( var_utc ).











  ENDMETHOD.
ENDCLASS.
