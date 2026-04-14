CLASS zcl_40_41_interface_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_41_interface_01 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA rental TYPE REF TO lcl_rental.
    DATA carrier TYPE REF TO lcl_carrier.

    rental = NEW #( iv_name = 'Breidenbach Auto Wunderland' ).

    carrier = NEW #( iv_name = 'Breidenbach BB Fly' ).

    out->write(  'Autovermmietung' ).
    out->write( rental->mv_name ).
    out->write( '-----------------' ).

    out->write(  'Flugesellschaft' ).
    out->write( carrier->mv_name ).
    out->write( '-----------------' ).


  ENDMETHOD.
ENDCLASS.
