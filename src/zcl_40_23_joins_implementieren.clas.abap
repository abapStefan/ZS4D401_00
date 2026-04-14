CLASS zcl_40_23_joins_implementieren DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_23_joins_implementieren IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

** 1 Beispiel
** Select Anweisung für einen Einzelsatz Carrier_id
*
*    SELECT SINGLE FROM /dmo/carrier
*             FIELDS carrier_id, name, currency_code
*              WHERE carrier_id = 'LH'
*              INTO @DATA(ls_result).
*
*     out->write( ls_result ).
*
** ENDSELECT.    " Wenn kein Select Single

** 2 Beispiel
** Select Anweisung für einen Einzelsatz Connection_id
*
*    SELECT SINGLE FROM /dmo/connection
*             FIELDS carrier_id, connection_id, airport_from_id, airport_to_id
*              WHERE carrier_id = 'LH'
*             INTO @DATA(ls_result).
*
*     out->write( ls_result ).

** 3 Beispiel INNER JOIN beiden Tabellen zusammen
*
*    SELECT FROM /dmo/carrier
*    INNER JOIN  /dmo/connection
*            ON /dmo/carrier~carrier_id = /dmo/connection~carrier_id      " Join Bedingung
*        FIELDS /dmo/carrier~carrier_id,
*               /dmo/carrier~name AS carrier_name,    " Ohnen AS CARRIER_NAME steht nur name in der Ausgabe
*               /dmo/connection~connection_id,
*               /dmo/connection~airport_from_id,
*               /dmo/connection~airport_to_id,
*               /dmo/carrier~currency_code
*        WHERE /dmo/carrier~currency_code = 'EUR'
*
*     INTO TABLE @DATA(ls_result).
*
*      out->write( ls_result ).

** 4 Beispiel
*
*    SELECT FROM /dmo/carrier
*    INNER JOIN  /dmo/connection
*            ON /dmo/carrier~carrier_id = /dmo/connection~carrier_id      " Join Bedingung
*
*        FIELDS /dmo/carrier~carrier_id,
*               name AS carrier_name,         " Spaltennamen Ohne Datenquelle
*               connection_id,
*               airport_from_id,
*               airport_to_id,
*               currency_code
*
*       WHERE /dmo/carrier~currency_code = 'EUR'
*
*         INTO TABLE @DATA(ls_result).
*
*      out->write( ls_result ).


** 5 Beispiel
*
*    SELECT FROM /dmo/carrier AS a
*    INNER JOIN  /dmo/connection AS b
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

* 6 Beispiel Erforderliche Aliase in Self Joins

*    SELECT FROM /dmo/connection AS a
*    INNER JOIN  /dmo/connection AS b
*            ON  a~airport_to_id = b~airport_from_id      " Join Bedingung
*           AND  a~airport_from_id <> b~airport_to_id      " Rückflüge werden ausgeschlossen
*
*        FIELDS a~airport_from_id,
*               concat_with_space(  a~carrier_id, a~connection_id, 1 )  AS Erster_Flug,
*
*               a~airport_to_id AS ueber_airport_id,
*               concat_with_space(  b~carrier_id, b~connection_id, 1 )  AS Zweiter_Flug,
*
*               b~airport_to_id
*
*
*       WHERE   a~airport_from_id = 'FRA'
*
*         INTO TABLE @DATA(ls_result).
*
*      out->write( ls_result ).

** 7 Beispiel Left outer
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



** 9 Beispiel Right Outer

*    SELECT FROM /dmo/Agency AS a
*          RIGHT OUTER JOIN /dmo/customer AS c
*             ON a~city         = c~city
*
*         FIELDS agency_id,
*                name AS Agency_name,
*                a~city AS agency_city,
*                c~city AS customer_city,
*                customer_id,
*                last_name AS customer_name
*
*          WHERE ( c~customer_id < '000010' OR c~customer_id IS NULL )
*            AND ( a~agency_id   < '070010' OR a~agency_id   IS NULL )
*
*           INTO TABLE @DATA(result_right).
*
*
*    out->write(
*      EXPORTING
*        data   = result_right
*        name   = 'Right Outer Join'
*    ).


** 10 Alle Beispiele

   select from /dmo/agency as a
*               inner join /dmo/customer as c
*           left outer join /dmo/customer as c
          right outer join /dmo/customer as c
             on a~city         = c~city

         fields agency_id,
                name as agency_name,
                a~city as agency_city,
                c~city as customer_city,
                customer_id,
                last_name as customer_name

          where ( c~customer_id < '000010' or c~customer_id is null )
            and ( a~agency_id   < '070010' or a~agency_id   is null )

           into table @data(result_inner).

out->write( `---------------------------------------------------------` ).

    out->write(
      exporting
        data   = result_inner
        name   = 'inner join'
    ).



  ENDMETHOD.
ENDCLASS.
