CLASS zcl_40_14_abschn_runden_verh DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_14_abschn_runden_verh IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Abschneiden und Runden vehindern


    DATA var_pack TYPE p LENGTH 3 DECIMALS 2.

    var_pack = 1 / 8.     " Bekannt var_pack hat 2 decimals Ergebns wir gerundet

    out->write( |1 / 8 = { var_pack number = user } | ).     " number = user ist eine formatoption

    TRY.
    var_pack = EXACT #( 1 / 8 ).
        CATCH cx_sy_conversion_error.
    out->write( |1 / 8 muss gerundet werden. Exact eine Ausnahme ausglöst| ).
    ENDTRY.







  ENDMETHOD.
ENDCLASS.
