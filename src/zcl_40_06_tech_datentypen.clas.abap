CLASS zcl_40_06_tech_datentypen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_06_tech_datentypen IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Eingebaute ABAP Standard Datentypen Vollständig

    DATA gv_num TYPE i.
    gv_num = 2147483647.     " Initialwert = 0
*  gv_num = gv_num + 1.     " Funktioniert nicht 10 Stellen und max von 214748347
    out->write( gv_num ).

    DATA gv_name TYPE string.   " Beliebige Zeichen und länge
    gv_name = 'Stefan'.
    out->write( gv_name ).

    DATA datum TYPE d.       " Ausgabe JJJJMMTT
    out->write( datum ).

    DATA zeit TYPE t.       " Ausgabe HHMMSS
    out->write( zeit ).

* Eingebaute ABAP Standard Datentypen unvollständig

    DATA name TYPE c LENGTH 11 VALUE 'Breidenbach'.
    out->write( name ).

    DATA plz TYPE n LENGTH 5.
    plz = 37170.
    out->Write( plz ).

    DATA erg TYPE p LENGTH 16 DECIMALS 14.
    erg = 10 / 3.
    out->write( erg ).


  ENDMETHOD.
ENDCLASS.
