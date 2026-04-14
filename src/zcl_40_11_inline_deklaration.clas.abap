CLASS zcl_40_11_inline_deklaration DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_11_inline_deklaration IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Fallstricke von Inline Deklarationen

   DATA(result1) = 5 * 10.

   out->write( |5 * 10 = { result1 }| ).    " Result1 ist vom Typ i Ergebnis ist ganze Zahl

    DATA(result2) = 5 / 10.

   out->write( |5 / 10 = { result2 }| ).   " " Result2 ist vom Typ i Ergebnis ist ganze Zahl gerundet

  ENDMETHOD.
ENDCLASS.
