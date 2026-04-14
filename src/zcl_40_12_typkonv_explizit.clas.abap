CLASS zcl_40_12_typkonv_explizit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_12_typkonv_explizit IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Konvertierung des Erzwungenen Typs Abb. 44
* Result hat den Typ C
* und wird unformatiert in der Konsole angezeit

    DATA(result1) = '20260319'.

    out->write( result1 ).           " Result ist vom Typ des Literalen Typs (Typ C )

* result2 muss vom Type D sein
* und wird mit Datumsformatierung in der Konsole angezeigt

    DATA(result2) = CONV d(  '20260319' ).

    out->write( result2 ).      " Result2 hat den Typ der Konvertierung (Typ D)

  ENDMETHOD.
ENDCLASS.
