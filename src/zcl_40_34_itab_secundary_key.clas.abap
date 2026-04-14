CLASS zcl_40_34_itab_secundary_key DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_34_itab_secundary_key IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA(flights) = NEW lcl_flights(  ).

     flights->access_standard(  ).
     flights->access_standard_second_key(  ).
     flights->access_standard_second_key_2(  ).
     flights->access_second_key_unique_1(  ).
     flights->access_second_key_unique_2(  ).


     flights->access_sorted(  ).
     flights->access_hashed(  ).

     out->write( 'ok' ).

  ENDMETHOD.
ENDCLASS.
