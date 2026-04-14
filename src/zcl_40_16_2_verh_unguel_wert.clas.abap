CLASS zcl_40_16_2_verh_unguel_wert DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_16_2_verh_unguel_wert IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Abschneiden und Runden

    DATA var_date TYPE d.

*   var_date = 'KASSALAA'.
*   out->write( var_date ).
*
*   TRY.
*      var_date = EXACT #( 'KASSALAA' ).
*      CATCH cx_sy_conversion_error.
*      out->write( | keine gültiger wert | ).

*   ENDTRY.

   var_date = '20260332'.
   out->write( var_date ).

   TRY.
      var_date = EXACT #( '20260332' ).
      CATCH cx_sy_conversion_error.
      out->write( |Das ist kein Gültiges Datum | ).

   ENDTRY.



  ENDMETHOD.
ENDCLASS.
