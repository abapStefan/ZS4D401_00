CLASS zcl_40_08_fallstrik_typkonv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_08_fallstrik_typkonv IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Nicht Erfolgreiche Typkonvertierung

    DATA var_string TYPE string.
    DATA var_int TYPE i.
    DATA var_pack TYPE p LENGTH 3 DECIMALS 2.

    TRY.

*   var_string = 'ABCDE'.      " Hier wird die Ausnahme cx_sy_conversion_no_number.
*   var_int = var_string.
*
*   out->write( var_int ).

        var_string = '1000'.       " Hier wir die Ausnahme CX_SY_CONVERSION_OVERFLOW aber 999.99 geht
        var_pack = var_string.

        out->write( var_pack ).

      CATCH cx_sy_conversion_no_number.
        out->write( |String ist kein integer| ).
      CATCH cx_sy_conversion_overflow.
        out->write( |Nummer ist zu lang| ).

    ENDTRY.



  ENDMETHOD.
ENDCLASS.
