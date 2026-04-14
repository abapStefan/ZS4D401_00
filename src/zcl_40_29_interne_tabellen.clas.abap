CLASS zcl_40_29_interne_tabellen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_29_interne_tabellen IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  TYPES tt_flights TYPE STANDARD TABLE OF /dmo/flight
*                   WITH NON-UNIQUE KEY carrier_id connection_id flight_date.
*
*  DATA flights TYPE tt_flights.
*
** Tabelle aus der Datenbank zu füllen
*
**  SELECT FROM /dmo/flight FIELDS * INTO TABLE @flights.
*
*
*    flights = VALUE #(  ( client = sy-mandt carrier_id = 'LH' connection_id = '0400' flight_date = '20260325' plane_type_id = '747-400' price = '600' currency_code = 'EUR'  )
*                        ( client = sy-mandt carrier_id = 'QF' connection_id = '0006' flight_date = '20260412' plane_type_id = 'A380'    price = '1600' currency_code = 'AUD' )
*                        ( client = sy-mandt carrier_id = 'AA' connection_id = '0017' flight_date = '20260510' plane_type_id = '747-400' price = '600' currency_code = 'USD'  )
*                        ( client = sy-mandt carrier_id = 'UA' connection_id = '0900' flight_date = '20260201' plane_type_id = '777-200' price = '600' currency_code = 'USD'  )
*                        ( client = sy-mandt carrier_id = 'LH' connection_id = '0400' flight_date = '20260824' plane_type_id = '747-400' price = '600' currency_code = 'EUR'  ) ).
*
*    out->write(  'Ausgabe vor Sort' ).
*    out->write(  '-----------------------------------------------------------------------------------' ).
*    out->write(  flights  ).
*    out->write(  ` ` ).
*
*
*    SORT flights.
*
*    out->write(  'Auswirkung von SORT ohne Zusätze – Sortieren nach Primärschlüssel der Tabelle' ).
*    out->write(  '----------------------------------------------------------------------------------' ).
*    out->write( flights ).
*    out->write(  ` ` ).
*
*    SORT flights BY currency_code plane_type_id.
*
*    out->write(  'Auswirkung von SORT mit Feldliste – aufsteigend ist die Standardreihenfolge' ).
*    out->write(  '----------------------------------------------------------------------------------' ).
*    out->write( flights ).
*    out->write(  ` ` ).
*
*
*    SORT flights BY flight_Date DESCENDING.
*
*    out->write(  'Auswirkung von SORT mit Feldliste und Sortierrichtung' ).
*    out->write(  '-----------------------------------------------------------------------------------' ).
*    out->write( flights ).
*    out->write(  ` ` ).
*
*    DELETE ADJACENT DUPLICATES FROM flights.
*
*    out->write(  'Auswirkung von DELETE ADJACENT DUPLICATES bleibt ohne Auswirkung  ' ).
*    out->write(  '-----------------------------------------------------------------------------------' ).
*    out->write( flights ).
*    out->write(  ` ` ).
*
*    DELETE ADJACENT DUPLICATES FROM flights
*    COMPARING carrier_id connection_id.
*
*    out->write(  'Auswirkung von DELETE ADJACENT DUPLICATES auch mit COMPARING bleibt ohne Auswirkung vor nicht Sortierung ' ).
*    out->write(  '-----------------------------------------------------------------------------------' ).
*    out->write( flights ).
*    out->write(  ` ` ).
*
*    sort flights BY carrier_id connection_id.   " Hier die Sortierung
*
*    DELETE ADJACENT DUPLICATES FROM flights
*    COMPARING carrier_id connection_id.
*
*    out->write(  'Auswirkung von DELETE ADJACENT DUPLICATES nach Sortierung mit COMPARING' ).
*    out->write(  '-----------------------------------------------------------------------------------' ).
*    out->write( flights ).
*    out->write(  ` ` ).

** Tabelle Ausdrücke Tabellen-Comprehenions

*    TYPES: BEGIN OF st_connection,
*             carrier_id             TYPE /dmo/carrier_id,
*             connection_id          TYPE /dmo/connection_id,
*             departure_airport      TYPE /dmo/airport_from_id,
*             departure_airport_name TYPE /dmo/airport_name,
*           END OF st_connection.
*
*    TYPES tt_connections TYPE STANDARD TABLE OF st_connection WITH NON-UNIQUE KEY carrier_id connection_id.
*
*    DATA connections   TYPE TABLE OF /dmo/connection.
*    DATA airports      TYPE TABLE OF /dmo/airport.
*    DATA result_table  TYPE tt_connections.
*
*    SELECT FROM /dmo/airport
*        FIELDS *
*        INTO TABLE @airports.
*
*    SELECT FROM /dmo/connection
*       FIELDS *
*       INTO TABLE @connections.
*
*
*    out->write( ' Connection Table' ).
*    out->write( '---------------------------------------------------------------------' ).
*    out->write( connections ).
*    out->write( ' ' ).
*
*    result_table = CORRESPONDING #( connections ).     " Beispiel Corresponding zuerst
*
*    result_table = VALUE #( FOR line IN connections
*                               (  carrier_id = line-carrier_id
*                                  connection_id = line-connection_id
*                                  departure_airport = line-airport_from_id
*                                  departure_airport_name = airports[ airport_id = line-airport_from_id ]-name ) ).
*
*
*    out->write( ' Ergebnis' ).
*    out->write( '-----------------------------------------------------------------------' ).
*    out->write( result_table ).
*    out->write( ' ' ).


    TYPES: BEGIN OF st_results,
             occupied TYPE /dmo/plane_seats_occupied,
             maximum  TYPE /dmo/plane_seats_max,
           END OF st_results.

    TYPES: BEGIN OF st_results_with_avg,
             occupied TYPE /dmo/plane_seats_occupied,
             maximum  TYPE /dmo/plane_seats_max,
             average  TYPE p LENGTH 16 DECIMALS 2,
           END OF st_results_with_avg.

    DATA flights TYPE TABLE OF /dmo/flight.

    SELECT FROM /dmo/flight
           FIELDS *
           INTO TABLE @flights.


    DATA sum TYPE i.

    sum = REDUCE #( INIT total = 0
                    FOR line IN flights
                    NEXT total  = total + line-seats_occupied ).

    out->write( ' Ergebnis ist ein scalarer Daten typ' ).
    out->write( '-----------------------------------------------------------------------' ).
    out->write( sum ).
    out->write( ' ' ).


    DATA(results) = REDUCE st_results( INIT totals TYPE st_results
                     FOR line IN flights
                     NEXT totals-occupied += line-seats_occupied
                          totals-maximum  += line-seats_max ).


    out->write( ' Ergebnis ist ein Structurierter Daten typ' ).
    out->write( '-----------------------------------------------------------------------' ).
    out->write( results ).
    out->write( ' ' ).


    DATA(result_with_average) = REDUCE st_results_with_avg( INIT totals_avg TYPE st_results_with_avg
                                                            count = 1
                                                            FOR line IN flights
                                                            NEXT totals_avg-occupied += line-seats_occupied
                                                                 totals_avg-maximum += line-seats_max
                                                                 totals_avg-average = totals_avg-occupied / count
                                                                 count += 1 ).

    out->write( ' Ergebnis mit Durchschnitt mit Hilfsvariable' ).
    out->write( '-----------------------------------------------------------------------' ).
    out->write( result_with_average ).




  ENDMETHOD.
ENDCLASS.
