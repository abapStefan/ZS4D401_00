CLASS zcl_40_27_spez_funct_abap_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_27_spez_funct_abap_sql IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*Beispiel Seite ABB 106

*    SELECT FROM /dmo/travel
*          FIELDS begin_date,
*                 end_date,
*                 is_valid( begin_date  )              AS valid,
*
*                 add_days( begin_date, 7 )            AS add_7_days,
*                 add_months(  begin_date, 3 )         AS add_3_months,
*                 days_between( begin_date, end_date ) AS duration,
*
*                 weekday( begin_date  )               AS weekday,
*                 extract_month( begin_date )          AS month,
*                 dayname( begin_date )                AS day_name
*
*           WHERE customer_id = '000001'
**            WHERE days_between( begin_date, end_date ) > 10 " oder so
*             AND days_between( begin_date, end_date ) = 0
*
*
*            INTO TABLE @DATA(result).
**
*    out->write(
*      EXPORTING
*        data   = result
*        name   = 'RESULT'
**    ).

**Beispiel Abbildung 108

    SELECT FROM /dmo/travel
         FIELDS lastchangedat,
                CAST( lastchangedat AS DEC( 15,0 ) ) AS latstchangedat_short,

                tstmp_to_dats( tstmp = CAST( lastchangedat AS DEC( 15,0 ) ),
                               tzone = CAST( 'UTC-5' AS CHAR( 6 ) )
                               "client = ... ,
                               "on_error = ...
                             ) AS date_est,
                tstmp_to_tims( tstmp = CAST( lastchangedat AS DEC( 15,0 ) ),
                               tzone = CAST( 'UTC-5' AS CHAR( 6 ) )
                             ) AS time_est

          WHERE customer_id = '000001'
           INTO TABLE @DATA(result_date_time).

    out->write(
      EXPORTING
        data   = result_date_time
        name   = 'Timestamp Conversion'
    ).

** Beispiel ABB 109
*
*       SELECT FROM /dmo/connection
*             FIELDS distance,
*                    distance_unit,
*                    unit_conversion(  quantity = CAST( distance AS Quan ),
*                                      source_unit = distance_unit,
*                                      target_unit = CAST( 'MI' AS UNIT ) ) AS distance_mi
*
*         WHERE airport_from_id = 'FRA'
*         into Table @DATA(result_unit).
*
*    out->write( result_unit ).

**Beispiel Abb 110.

*       DATA(today) = cl_abap_context_info=>get_system_date(  ).
*
*       SELECT FROM /dmo/travel
*            FIELDS total_price,
*                   currency_code,
*
*                   currency_conversion( amount             = total_price,
*                                        source_currency    = currency_code,
*                                        target_currency    = 'EUR',
*                                        exchange_rate_date = @today
*                                       ) AS total_price_eur
*
*              WHERE customer_id = '0000003' AND currency_code <> 'EUR'
*                 INTO TABLE @DATA(result_currency).
*
*           out->write( result_currency ).



  ENDMETHOD.
ENDCLASS.
