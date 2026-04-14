CLASS zcl_40_constructor_reihenfolge DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_constructor_reihenfolge IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA ober TYPE REF TO lcl_super1.
  DATA unter TYPE REF TO lcl_sub1.

  create object unter.

  LOOP AT lcl_super1=>table INTO DATA(oha).
  out->write( oha ).
  ENDLOOP.


  ENDMETHOD.
ENDCLASS.
