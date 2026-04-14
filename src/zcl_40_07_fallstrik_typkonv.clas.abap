CLASS zcl_40_07_fallstrik_typkonv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_07_fallstrik_typkonv IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Erfolgreiche Typkonvertierung

   DATA var_string TYPE string.
   DATA var_int TYPE i.
   DATA var_date TYPE d.

   var_string = '12345'.
   var_int = var_string.

   out->write( var_int ).

   var_string = '20260319'.
   var_date = var_string.

   out->write( var_date ).


  ENDMETHOD.
ENDCLASS.
