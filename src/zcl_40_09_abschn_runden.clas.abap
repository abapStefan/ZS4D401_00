CLASS zcl_40_09_abschn_runden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_09_abschn_runden IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Abschneiden und Runden

    DATA var_string TYPE string.
    DATA var_char TYPE c LENGTH 3.
    DATA var_pack TYPE p LENGTH 3 DECIMALS 3.

   var_string = 'Breidenbach'.
   var_char = var_string.

   out->write( var_char ).                     " Hier kommt nur Bre inhalt wird abgeschnitten

   var_pack = 1 / 4.

   out->write( var_pack ).

   var_pack = 1 / 8.

   out->write( var_pack ).





  ENDMETHOD.
ENDCLASS.
