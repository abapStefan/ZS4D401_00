CLASS zcl_40_10_unerw_ergebnisse DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_10_unerw_ergebnisse IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Unerwartete Ergebnisse von Zuordungen

    DATA var_date TYPE d.
    DATA var_string TYPE string.
    DATA var_int TYPE i.
    DATA var_n TYPE n LENGTH 4 .

    var_date = cl_abap_context_info=>get_system_date(  ).

    out->write( var_date ).    " Hier kommt das Systemdatum

    var_int = var_date.

    out->write( var_int ).      " Anzahl der Tage seit 01.01.0001

    var_string = 'R2D2'.

    var_n = var_string.

    out->write( var_n ).        " 0022 weil ungültige Zeichen entfernt werden

    var_date = 'KASALLAA'.      " Warnung, aber Datum kann ungültige Werte enthalten

    out->write( var_date ).







  ENDMETHOD.
ENDCLASS.
