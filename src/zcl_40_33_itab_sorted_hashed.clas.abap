CLASS zcl_40_33_itab_sorted_hashed DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_33_itab_sorted_hashed IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA(flights) = NEW lcl_flights(  ).

     flights->access_standard(  ).
     flights->access_sorted(  ).
     flights->access_hashed(  ).

     out->write( 'ok' ).

  ENDMETHOD.
ENDCLASS.
