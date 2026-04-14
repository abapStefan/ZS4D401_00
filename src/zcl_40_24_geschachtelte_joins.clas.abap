CLASS zcl_40_24_geschachtelte_joins DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_24_geschachtelte_joins IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

** 7 Beispiel 2 Quelle,
*
*    SELECT FROM /dmo/carrier AS a
*    LEFT OUTER JOIN  /dmo/connection AS b
*            ON  a~carrier_id = b~carrier_id      " Join Bedingung
*
*        FIELDS a~carrier_id,
*               name AS carrier_name,         " Spaltennamen Ohne Datenquelle
*               connection_id,
*               airport_from_id,
*               airport_to_id,
*               currency_code
*
*       WHERE   currency_code = 'EUR'
*
*         INTO TABLE @DATA(ls_result).
*
*      out->write( ls_result ).


* 3 Quellen

*
*    SELECT FROM (    /dmo/carrier AS a
*    INNER JOIN  /dmo/connection AS b
*            ON  a~carrier_id = b~carrier_id      " Join Bedingung
*                )
*
*    LEFT OUTER JOIN /dmo/airport AS apf
*            ON b~airport_from_id = apf~airport_id
*
*
*        FIELDS a~carrier_id,
*               a~name AS carrier_name,         " Spaltennamen Ohne Datenquelle
*               connection_id,
*               airport_from_id,
*               airport_to_id,
*               apf~city,
*               currency_code
*
*       WHERE   currency_code = 'EUR'
*
*         INTO TABLE @DATA(ls_result).
*
*      out->write( ls_result ).

** 4 Quellen
*
*
*    SELECT FROM ( (   /dmo/carrier AS a
*    INNER JOIN  /dmo/connection AS b
*            ON  a~carrier_id = b~carrier_id      " Join Bedingung
*                )
*
*    LEFT OUTER JOIN /dmo/airport AS apf
*            ON b~airport_from_id = apf~airport_id
*                )
*
*    LEFT OUTER JOIN /dmo/airport AS apt
*            ON b~airport_to_id = apt~airport_id
*
*        FIELDS a~carrier_id,
*               a~name AS carrier_name,         " Spaltennamen Ohne Datenquelle
*               connection_id,
*               airport_from_id,
*               apf~city,
*               airport_to_id,
*               apt~city AS to_city,
*               currency_code
*
*       WHERE   currency_code = 'EUR'
*
*         INTO TABLE @DATA(ls_result).
*
*      out->write( ls_result ).


* Join Reihenfolge " Joins nur auf rechter seite

*
    SELECT FROM  /dmo/carrier AS a
   LEFT OUTER JOIN
       (  (   /dmo/connection AS b


LEFT OUTER JOIN /dmo/airport AS apf
      ON b~airport_from_id = apf~airport_id
          )

LEFT OUTER JOIN /dmo/airport AS apt
      ON b~airport_to_id = apt~airport_id
         )

  ON  a~carrier_id = b~carrier_id      " Join Bedingung

  FIELDS a~carrier_id,
         a~name AS carrier_name,         " Spaltennamen Ohne Datenquelle
         connection_id,
         airport_from_id,
         apf~city,
         airport_to_id,
         apt~city AS to_city,
         currency_code

 WHERE   currency_code = 'EUR'

   INTO TABLE @DATA(ls_result).

    out->write( ls_result ).


  ENDMETHOD.
ENDCLASS.
