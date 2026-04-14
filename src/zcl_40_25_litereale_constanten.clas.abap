CLASS zcl_40_25_litereale_constanten DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_25_litereale_constanten IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

     CONSTANTS c_number TYPE i VALUE 12345.

     SELECT FROM /dmo/carrier

          FIELDS 'Hello' AS character,
                 '1313' AS character2,
                    1    AS integer1,
                   -1    AS interger2,
                  256    AS integer3,
                 32768   AS interger4,


              @c_number AS Konstante   " @ bei Constanten obligatorisch muss

      INTO TABLE @DATA(result).

      out->write( result ).            " 16 Einträge, weil die Tabelle carrier 16 Einträge hat

  ENDMETHOD.
ENDCLASS.
