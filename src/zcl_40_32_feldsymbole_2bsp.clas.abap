CLASS zcl_40_32_feldsymbole_2bsp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_32_feldsymbole_2bsp IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Führt mal diese Klasse mit dem Profil As->ABAP Application aus.

* Betrachtet dann in der Analyse die vergleichenden Laufzeiten von

* den Methoden loop_work_area( ) und loop_field_symbol( )

    DATA(flights) = NEW lcl_demo(  ).

    flights->use_work_area(   ).
    flights->use_field_symbol(   ).
    out->write( `Done` ).
data a.


  ENDMETHOD.
ENDCLASS.
