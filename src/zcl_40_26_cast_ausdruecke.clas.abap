CLASS zcl_40_26_cast_ausdruecke DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_26_cast_ausdruecke IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  DATA lv_demo_1 TYPE c LENGTH 20.
*  DATA ls_demo_1 TYPE /dmo/carrier.
*  DATA lv_demo_2 TYPE /dmo/carrier_id.
*
*
**  SELECT SINGLE FROM /dmo/carrier FIELDS 'Demo-1' as a, 'Demo2' as b
**              INTO @DATA(ls_result).
*
*   SELECT FROM /dmo/carrier
*           FIELDS carrier_id, 20 as c, 'Demo-1' as a, 'Demo-2' as b
*
*            WHERE carrier_id = 'LH' INTO TABLE @DATA(ls_result).
*
*   out->write( ls_result ).


*     SELECT SINGLE
*             FROM /dmo/connection
*             FIELDS airport_from_id,
*             `Demo-1` AS demo_1, `Demo2` AS demo_2, '123' && '567' AS kette,
*              CAST( '20260326' AS char( 6 ) ) AS banane,
*              CAST( '20260326' AS FLTP ) AS birne,
*              CAST( 'kassalla' AS DATS ) AS DATE,
*              CAST( '20260323' AS DATS ) AS DATUM,
*              CAST( '12345678' AS DEC( 10,2 ) ) AS dec_info     " Hier Runtime Error
*
*              INTO @DATA(ls_demo).
*
*          out->write( ls_demo ).

**  Einfache Fallunterscheidung

*      SELECT FROM /dmo/customer
*               FIELDS customer_id,
*               title,
*               CASE title
*                 WHEN 'Mr.'   THEN 'Herr'
*                 WHEN 'Mrs.'  THEN 'Frau'
*                 ELSE              ' '
*               END AS title_long
*
*            WHERE country_code = 'AT'
*            INTO TABLE @DATA(result_simple).
*
*     out->write( data = result_simple
*                 name = 'Einfache Fallunterscheidung' ).

**  Komplexe Fallunterscheidung
*
*    SELECT FROM /dmo/flight
*               FIELDS flight_date,
*                      seats_max,
*                      seats_occupied,
*                CASE
*                   WHEN seats_occupied  < seats_max THEN 'Plätze verfügbar'
*                   WHEN seats_occupied  = seats_max  THEN 'Ausgebucht'
*                   WHEN seats_occupied  > seats_max THEN 'Überbucht'
*
*                ELSE                                     ' Das ist nicht möglich'
*
*                END AS booking_state
*
*             WHERE carrier_id = 'AA'
*             AND connection_id = '0017'
*             INTO TABLE @DATA(result_complex).
*
*           out->write( data = result_complex
*                 name = 'Komplexe Fallunterscheidung' ).


 SELECT FROM /dmo/flight
               FIELDS flight_date,
                      seats_max,
                      seats_occupied,
                      seats_max - seats_occupied   AS seats_avaliable,

               CAST(
                    (  CAST( seats_occupied AS fltp  )
                      * CAST( 100 AS fltp )
                      ) / CAST( seats_max AS fltp ) AS DEC( 10,2 )  ) AS percentage_dec,

                     (  cast( seats_occupied AS fltp )
                        * CAST(  100 AS FLTP  )
                      ) / cast(  seats_max AS fltp ) AS   percentage_fltp

               WHERE carrier_id = 'LH'
               INTO TABLE @DATA(result).

          out->write( result ).
*
*          DATA lv_dec TYPE p DECIMALS 2.

*          LOOP AT result ASSIGNING FIELD-SYMBOL(<fs>).
*          lv_dec = <fs>-percentage_fltp.
*          out->write( lv_dec ).
*          ENDLOOP.

**    DATA lv_dec TYPE p DECIMALS 2.
*    LOOP AT result ASSIGNING FIELD-SYMBOL(<fs1>).
*      lv_dec = <fs1>-percentage_fltp.
*      out->write( | { <fs1>-seats_max } { <fs1>-seats_occupied } { <fs1>-seats_avaliable }  { lv_dec  }  |    ).
*    ENDLOOP.


* Abbildung 98.
*    SELECT FROM /dmo/flight
*             FIELDS seats_max,
*                    seats_occupied,
*
*                    (   CAST( seats_occupied AS FLTP )
*                      * CAST( 100 AS FLTP )
*                    ) / CAST(  seats_max AS FLTP )                  AS percentage_fltp,
*
*                    div( seats_occupied * 100 , seats_max )         AS percentage_int,
*
*                    division(  seats_occupied * 100, seats_max, 4 ) AS percentage_dec_
*
*              WHERE carrier_id    = 'LH'
*               INTO TABLE @DATA(result).
*
*    out->write(
*      EXPORTING
*        data   = result
*        name   = 'RESULT'
*    ).

** Abbildung 98 “ 101
*SELECT FROM /dmo/customer
*         FIELDS customer_id,
*
*                street && ',' && ' '  && postal_code && ' ' && city   AS address_expr,
*
*                concat( street,
*                        concat_with_space(  ',',
*                                             concat_with_space( postal_code,
*                                                                upper(  city ),
*                                                                1
*                                                              ),
*                                            1
*                                         )
*                     ) AS address_func
*
*          WHERE country_code = 'ES'
*           INTO TABLE @DATA(result_concat).
*
*    out->write(
*      EXPORTING
*        data   = result_concat
*        name   = 'Concatenation'
*    ).


** Abbildung  102

*    SELECT FROM /dmo/carrier
*          FIELDS carrier_id,
*                 name,
*                 upper( name ) AS name_upper,
*                 lower( name ) AS name_lower,
*                 initcap( name ) AS name_initcap
*
*          WHERE carrier_id = 'SR'
*          INTO TABLE @DATA(erg_transform).
*
*      out->write( erg_transform ) .

** Abbildung 103

*     SELECT FROM /dmo/flight
*          FIELDS flight_date,
*                CAST(  flight_date AS char( 8 ) ) AS flight_date_raw,
*
*                left(  flight_date, 4 ) AS jahr,
*                right(  flight_date, 2 ) AS Tag,
*                substring( flight_date, 5, 2 ) AS Monat
*
*           WHERE carrier_id = 'LH'
*           ANd connection_id = '0400'
*           INTO TABLE @DATA(result_substring).
*
*           out->write( result_substring ).












  ENDMETHOD.
ENDCLASS.
