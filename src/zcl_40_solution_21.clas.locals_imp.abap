*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

INTERFACE lif_output.                                                  " Übung 21 / 1

  TYPES t_output TYPE string.                                          " Übung  21 / 5

  TYPES tt_output TYPE STANDARD TABLE OF t_output                      " Übung 21 / 6
                  WITH NON-UNIQUE DEFAULT KEY.                         " Übung 21 / 3
  METHODS get_output RETURNING VALUE(r_result) TYPE tt_output.         " Übung 21 / 4

ENDINTERFACE.


*class lcl_flight definition create private.                        " Übung 19
CLASS lcl_flight DEFINITION ABSTRACT.

  PUBLIC SECTION.

      INTERFACES lif_output.                                        " Übung 21 / 2

    METHODS constructor                                             " Übung 19 aus lcl_passenger kopiert
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
        i_flight_date   TYPE /dmo/flight_date.


    TYPES: tab TYPE STANDARD TABLE OF REF TO lcl_flight WITH DEFAULT KEY,             " Übung 20

           BEGIN OF st_connection_details,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             departure_time  TYPE /dmo/flight_departure_time,
             arrival_time    TYPE /dmo/flight_departure_time,
             duration        TYPE i,
           END OF st_connection_details.

    DATA carrier_id    TYPE /dmo/carrier_id       READ-ONLY.
    DATA connection_id TYPE /dmo/connection_id    READ-ONLY.
    DATA flight_date   TYPE /dmo/flight_date      READ-ONLY.


    METHODS: get_connection_details
      RETURNING
        VALUE(r_result) TYPE st_connection_details,
             get_description
                   RETURNING VALUE(r_result) TYPE string_table.


  PROTECTED SECTION.

    DATA connection_details TYPE st_connection_details.
    DATA planetype TYPE /dmo/plane_type_id.



  PRIVATE SECTION.


ENDCLASS.

CLASS lcl_flight IMPLEMENTATION.

  METHOD get_connection_details.
    r_result = me->connection_details.
  ENDMETHOD.

  METHOD get_description.

* Übung 09 / 2

    DATA txt TYPE string.

    txt = 'Flight &carrid& &connid& on &date& from &from& to &to&'(005).

    txt = replace( val = txt sub = '&carrid&' with = carrier_id ).
    txt = replace( val = txt sub = '&connid&' with = connection_id ).
    txt = replace( val = txt sub = '&date&' with = |{ flight_date DATE = USER } | ).
    txt = replace( val = txt sub = '&from&' with = connection_details-airport_from_id ).
    txt = replace( val = txt sub = '&to&' with = connection_details-airport_to_id ).

* Übung 09 / 1 dieses kommentieren
*    APPEND |Flight { carrier_id } { connection_id } on { flight_date DATE = USER } | &&
*           |from { connection_details-airport_from_id } to { connection_details-airport_to_id } |
*           TO r_result.

    APPEND txt TO r_result.

    APPEND |{ 'Planetype:'(006) }      { planetype  } | TO r_result.
    " Übung 7 Aufgabe 2

  ENDMETHOD.


  METHOD constructor.

    me->carrier_id = i_carrier_id.
    me->connection_id = i_connection_id.
    me->flight_date = i_flight_date.

  ENDMETHOD.

  METHOD lif_output~get_output.

     r_result = get_description( ).                                              " Übung 21 / 7

  ENDMETHOD.

ENDCLASS.

CLASS lcl_passenger_flight DEFINITION INHERITING FROM lcl_flight.

  PUBLIC SECTION.


    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
        i_flight_date   TYPE /dmo/flight_date.

    TYPES
      tt_flights TYPE STANDARD TABLE OF REF TO lcl_passenger_flight WITH DEFAULT KEY.


    METHODS
      get_free_seats
        RETURNING
          VALUE(r_result) TYPE i.


    CLASS-METHODS class_constructor.
    CLASS-METHODS
      get_flights_by_carrier
        IMPORTING
          i_carrier_id    TYPE /dmo/carrier_id
        RETURNING
          VALUE(r_result) TYPE tt_flights.

          METHODS get_description REDEFINITION.


  PROTECTED SECTION.


  PRIVATE SECTION.

    DATA seats_max  TYPE /dmo/plane_seats_max.
    DATA seats_occ  TYPE /dmo/plane_seats_occupied.
    DATA seats_free TYPE i.

    DATA price TYPE /dmo/flight_price.
    CONSTANTS currency TYPE /dmo/currency_code VALUE 'EUR'.
    TYPES: BEGIN OF st_flights_buffer,
             carrier_id     TYPE /lrn/passflight-carrier_id,                  " Aufgabe 4 / 2 Änderung
             connection_id  TYPE /lrn/passflight-connection_id,
             flight_date    TYPE /lrn/passflight-flight_date,
             plane_type_id  TYPE /lrn/passflight-plane_type_id,
             seats_max      TYPE /lrn/passflight-seats_max,
             seats_occupied TYPE /lrn/passflight-seats_occupied,
             seats_free     TYPE  i,                                          " Übung 11 / 1
             price          TYPE /lrn/passflight-price,
             currency_code  TYPE /lrn/passflight-currency_code,
           END OF st_flights_buffer.

*    CLASS-DATA: flights_buffer TYPE TABLE OF st_flights_buffer.              " Aufgabe 16 / 3
*     CLASS-DATA: flights_buffer                                               " Aufgabe 16 / 4   Aufgabe 17 / 1 kommentieren
*                 TYPE SORTED TABLE OF st_flights_buffer
*                 WITH NON-UNIQUE KEY carrier_id connection_id flight_date.

    CLASS-DATA: flights_buffer                                               " Aufgabe 17 / 2
               TYPE HASHED TABLE OF st_flights_buffer
               WITH UNIQUE KEY carrier_id connection_id flight_date
               WITH NON-UNIQUE SORTED KEY sk_carrier COMPONENTS carrier_id.





    TYPES:                                                                     " Aufgabe 5 / 1 Struktur einfühen umbenenen
      BEGIN OF st_connections_buffer,
        carrier_id      TYPE /dmo/carrier_id,
        connection_id   TYPE /dmo/connection_id,
        airport_from_id TYPE /dmo/airport_from_id,
        airport_to_id   TYPE /dmo/airport_to_id,
        departure_time  TYPE /dmo/flight_departure_time,
        arrival_time    TYPE /dmo/flight_arrival_time,
        timzone_from    TYPE timezone,                                        " Übung 10 / 2
        timzone_to      TYPE timezone,
*        distance        TYPE /dmo/flight_distance,
*        distance_unit   TYPE msehi,
        duration        TYPE i,
      END OF st_connections_buffer.

*    CLASS-DATA connections_buffer TYPE TABLE OF st_connections_buffer.         " Aufgabe 5 / 2 Übung 16 / 1
    CLASS-DATA: connections_buffer                                             " Aufgabe 16 / 2
                TYPE HASHED TABLE OF st_connections_buffer
                WITH UNIQUE KEY carrier_id connection_id .


ENDCLASS.

CLASS lcl_passenger_flight IMPLEMENTATION.

  METHOD class_constructor.

*    SELECT
*            FROM /lrn/airport                              " übung 7           " Übung 10 / 4
*          FIELDS airport_id, timzone
*            INTO TABLE @DATA(airports).


    DATA(today) = cl_abap_context_info=>get_system_date(  ).                     " Übung 12 vor die Select Anweisung setzten

    SELECT FROM /dmo/connection AS c                                            " Übung 10 / 1

           LEFT OUTER JOIN /lrn/airport AS f
                  ON c~airport_from_id = f~airport_id

           LEFT OUTER JOIN /lrn/airport AS t
                  ON c~airport_to_id = t~airport_id
               FIELDS carrier_id, connection_id,
                 airport_from_id, airport_to_id, departure_time, arrival_time,
                 f~timzone AS timezone_from,
                 t~timzone AS timezone_to,
                 div(
                 tstmp_seconds_between(
                        tstmp1 = dats_tims_to_tstmp(
                                 date = @today,
                                 time = c~departure_time,
                                 tzone = f~timzone ),

                        tstmp2 = dats_tims_to_tstmp(
                                 date = @today,
                                 time = c~arrival_time,
                                 tzone = t~timzone ) )
                                 , 60 ) AS duration

            INTO TABLE @connections_buffer.


    " Aufgabe 5 / 3 Class-Constructor erstellen
    " und Select Anweisung einfügen
*    SELECT FROM /lrn/connection
*       FIELDS carrier_id, connection_id, airport_from_id, airport_to_id,
*              departure_time, arrival_time, distance, distance_unit
*       INTO TABLE @connections_buffer.

*     DATA(today) = cl_abap_context_info=>get_system_date(  ).                       " Übung 7 Aufgabe 4

**   Übung 12 / 2 diesen Loop gesamt Kommentieren

*     LOOP AT connections_buffer INTO data(connection).                              " Übung 7 AUFGABE 3
*         Convert DATE today                                                         " Alles Übung 7 Aufgabe 5
*                 TIME connection-departure_time
**                 TIME ZONE airports[ airport_id = connection-airport_from_id ]-TIMZONE INTO
**                  UTCLONG DATA(departure_utclong).
*                 TIME ZONE connection-timzone_from                                 " Übung 10 / 3
*                 INTO UTCLONG DATA(departure_utclong).
*
*         Convert DATE today
*                 TIME connection-arrival_time
**                 TIME ZONE airports[ airport_id = connection-airport_to_id ]-TIMZONE INTO
**                  UTCLONG DATA(arrival_utclong).
*                 TIME ZONE connection-timzone_to                                    " Übung 10 / 3
*                 INTO UTCLONG DATA(arrival_utclong).
*
*            connection-duration = utclong_diff(  high = arrival_utclong
*                                                  low = departure_utclong ) / 60.
*
*        Modify connections_buffer FROM connection TRANSPORTING duration.
*
*         ENDLOOP.


  ENDMETHOD.

  METHOD get_flights_by_carrier.

    IF NOT line_exists( flights_buffer[ KEY sk_carrier       " Aufgabe 14 / 4 IF Anweisung
                                        COMPONENTS carrier_id = i_carrier_id ] ).                " Aufgabe 17 / 3

      SELECT
        FROM /lrn/passflight
      FIELDS carrier_id, connection_id, flight_date,
             plane_type_id, seats_max, seats_occupied,
             seats_max - seats_occupied AS seats_free,                        " Übung 11 / 2
*           price, currency_code                                            " Übung 12 / 3
            currency_conversion( amount      = price,
                          source_currency    = currency_code,
                          target_currency    = @currency,
                          exchange_rate_date = flight_date,
                          on_error = @sql_currency_conversion=>c_on_error-set_to_null ) AS price,
                          @currency AS currency_code

       WHERE carrier_id    = @i_carrier_id
*     ORDER BY flight_date ASCENDING                                          " Übung 13 / 1
*      INTO TABLE @flights_buffer.                                            " Aufgabe 4 / 1 Änderung
       APPENDING TABLE @flights_buffer.                                         " Aufgabe 14 / 2

*    SORT flights_buffer BY carrier_id connection_id flight_date.             " Aufgabe 16 / 5      " Aufgabe 14 / 3 später wieder kommentieren
*    DELETE ADJACENT DUPLICATES FROM flights_buffer
*    COMPARING carrier_id connection_id flight_date.

    ENDIF.

*    LOOP AT flights_buffer INTO DATA(flight).                                 " Aufgabe 14_1

*         WHERE carrier_id = i_carrier_id.                                     " Aufgabe 14
*
*      APPEND NEW lcl_passenger_flight( i_carrier_id    = flight-carrier_id
*                                       i_connection_id = flight-connection_id
*                                       i_flight_date   = flight-flight_date )
*              TO r_result.
*    ENDLOOP.

    r_result = VALUE #(
                FOR <flight> IN flights_buffer                                " Übung 15 / 1

                USING KEY sk_carrier                                          " Übung 17 / 4

              WHERE ( carrier_id = i_carrier_id )
               (
*                 NEW lcl_passenger_flight(
*                            i_carrier_id = flight-carrier_id
*                            i_connection_id = flight-connection_id
*                            i_flight_date = flight-flight_date  ) ) ).

                            NEW lcl_passenger_flight(                          " Übung 15 / 2
                           i_carrier_id = <flight>-carrier_id
                           i_connection_id = <flight>-connection_id
                           i_flight_date = <flight>-flight_date  ) ) ).

  ENDMETHOD.


  METHOD constructor.
    super->constructor( i_carrier_id = i_carrier_id                       " Übung 19
                        i_connection_id = i_connection_id
                        i_flight_date = i_flight_date ).

    TRY.

        DATA(flight_raw) = flights_buffer[ carrier_id = i_carrier_id                  " Aufgabe 4 / 3 Änderung
                                           connection_id = i_connection_id
                                           flight_date = i_flight_date ].

      CATCH cx_sy_itab_line_not_found.                                              " Augabe 4 / 6 Änderung

        SELECT SINGLE
          FROM /lrn/passflight
        FIELDS plane_type_id, seats_max, seats_occupied,
               seats_max - seats_occupied AS seats_free,                             " Übung 11 / 3
*               price,                                                               " Übung 12 / 5

               currency_conversion( amount      = price,
                        source_currency    = currency_code,
                        target_currency    = @currency,
                        exchange_rate_date = flight_date,
                        on_error = @sql_currency_conversion=>c_on_error-set_to_null ) AS price,

*              currency_code                                                          " Übung 12 / 6
                        @currency AS currency_code

         WHERE carrier_id    = @i_carrier_id
           AND connection_id = @i_connection_id
           AND flight_date   = @i_flight_date
          INTO CORRESPONDING FIELDS OF @flight_raw.                                    " Aufgabe 4 / 5 Änderung

    ENDTRY.

    IF flight_raw IS NOT INITIAL.                                                  " Aufgabe 4 / 7 Änderung
      me->carrier_id    = i_carrier_id.
      me->connection_id = i_connection_id.
      me->flight_date   = i_flight_date.

      planetype = flight_raw-plane_type_id.
      seats_max = flight_raw-seats_max.
      seats_occ = flight_raw-seats_occupied.
*      seats_free = flight_raw-seats_max - flight_raw-seats_occupied.
      seats_free = flight_raw-seats_free.                                           " Übung 11 / 4
      price      = flight_raw-price.          " Übung 12 WICHTIG sonst NULL
* convert currencies
*      TRY.                                                                         " Übung 12 / 4 alles Kommentieren
*          cl_exchange_rates=>convert_to_local_currency(
*            EXPORTING
*              date              = me->flight_date
*              foreign_amount    = flight_raw-price
*              foreign_currency  = flight_raw-currency_code
*              local_currency    = me->currency
*            IMPORTING
*              local_amount      = me->price
*          ).
*        CATCH cx_exchange_rates.
*          price = flight_raw-price.
*      ENDTRY.

* Set connection details                                                         " Aufgabe 5 / 4 Kommentieren
*      SELECT SINGLE
*        FROM /dmo/connection
*      FIELDS airport_from_id, airport_to_id, departure_time, arrival_time
*       WHERE carrier_id    = @carrier_id
*         AND connection_id = @connection_id
*        INTO @connection_details .

      connection_details = CORRESPONDING #(   connections_buffer[                 " Aufgabe 5 / 4 ITAB mit Corresponding
                            carrier_id = i_carrier_id
                            connection_id = i_connection_id ] ).
    ENDIF.

  ENDMETHOD.



  METHOD get_free_seats.
    r_result = me->seats_free.
  ENDMETHOD.

  METHOD get_description.
    r_result = super->get_description(  ).

    APPEND |{ 'Maximum Seats:'(007) }  { seats_max  } | TO r_result.
    APPEND |{ 'Occupied Seats:'(008) } { seats_occ } | TO r_result.
    APPEND |{ 'Free Seats:'(009) }     { seats_free } | TO r_result.
    APPEND |{ 'Ticket Price:'(010) }   { price CURRENCY = currency } { currency } | TO r_result.
    APPEND |{ 'Duration:'(011) }       { connection_details-duration } { 'minutes'(012) } | TO r_result.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_cargo_flight DEFINITION INHERITING FROM lcl_flight .               " Übung 19

  PUBLIC SECTION.

*    TYPES: BEGIN OF st_connection_details,                                  " Übung 19
*             airport_from_id TYPE /dmo/airport_from_id,
*             airport_to_id   TYPE /dmo/airport_to_id,
*             departure_time  TYPE /dmo/flight_departure_time,
*             arrival_time    TYPE /dmo/flight_departure_time,
*             duration        TYPE i,
*           END OF st_connection_details.

    TYPES
       tt_flights TYPE STANDARD TABLE OF REF TO lcl_cargo_flight WITH DEFAULT KEY.

*Falsch                                                                              Aufgabe 6
*    DATA carrier_id    TYPE /dmo/connection_id    READ-ONLY.                      " Hier flasche zuweisung
*    DATA connection_id TYPE /dmo/carrier_id       READ-ONLY.                      " Hier falsche Zuweisung

* Richtig
*    DATA carrier_id    TYPE /dmo/carrier_id       READ-ONLY.                      " Übung 19
*    DATA connection_id TYPE /dmo/connection_id    READ-ONLY.                      " Übung 19
*    DATA flight_date   TYPE /dmo/flight_date      READ-ONLY.                      " Übung 19

    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
        i_flight_date   TYPE /dmo/flight_date.

*    METHODS get_connection_details                                                 " Übung 19
*      RETURNING
*        VALUE(r_result) TYPE st_connection_details.

    METHODS
      get_free_capacity
        RETURNING
          VALUE(r_result) TYPE /lrn/plane_actual_load.

*    METHODS get_description                                                        " Übung 19
*      RETURNING
*        VALUE(r_result) TYPE string_table.

    CLASS-METHODS
      get_flights_by_carrier
        IMPORTING
          i_carrier_id    TYPE /dmo/carrier_id
        RETURNING
          VALUE(r_result) TYPE tt_flights.

          METHODS get_description REDEFINITION.


  PROTECTED SECTION.


  PRIVATE SECTION.

    TYPES: BEGIN OF st_flights_buffer,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             flight_date     TYPE /dmo/flight_date,
             plane_type_id   TYPE /dmo/plane_type_id,
             maximum_load    TYPE /lrn/plane_maximum_load,
             actual_load     TYPE /lrn/plane_actual_load,
             load_unit       TYPE /lrn/plane_weight_unit,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             departure_time  TYPE /dmo/flight_departure_time,
             arrival_time    TYPE /dmo/flight_arrival_time,
           END OF st_flights_buffer.

    TYPES tt_flights_buffer TYPE HASHED TABLE OF st_flights_buffer
                            WITH UNIQUE KEY carrier_id connection_id flight_date.

*    DATA connection_details TYPE st_connection_details.                                " Übung 19

*    DATA planetype TYPE /dmo/plane_type_id.                                            " Übung 19

    DATA maximum_load TYPE /lrn/plane_maximum_load.
    DATA actual_load TYPE /lrn/plane_actual_load.
    DATA load_unit    TYPE /lrn/plane_weight_unit.

    CLASS-DATA flights_buffer TYPE tt_flights_buffer.

ENDCLASS.

CLASS lcl_cargo_flight IMPLEMENTATION.

  METHOD get_flights_by_carrier.

    SELECT
      FROM /lrn/cargoflight
    FIELDS carrier_id, connection_id, flight_date,
           plane_type_id, maximum_load, actual_load, load_unit,
           airport_from_id, airport_to_id, departure_time, arrival_time
     WHERE carrier_id    = @i_carrier_id
     ORDER BY flight_date ASCENDING                                                      " Übung 13 / 2
      INTO CORRESPONDING FIELDS OF TABLE @flights_buffer.

    LOOP AT flights_buffer INTO DATA(flight).
      APPEND NEW lcl_cargo_flight( i_carrier_id    = flight-carrier_id
                                   i_connection_id = flight-connection_id
                                   i_flight_date   = flight-flight_date )
              TO r_result.

    ENDLOOP.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( i_carrier_id = i_carrier_id
                        i_connection_id = i_connection_id
                        i_flight_date = i_flight_date ).

    " Read buffer
    TRY.
        DATA(flight_raw) = flights_buffer[ carrier_id    = i_carrier_id
                                           connection_id = i_connection_id
                                           flight_date   = i_flight_date ].

      CATCH cx_sy_itab_line_not_found.
        " Read from database if data not found in buffer
        SELECT SINGLE
          FROM /lrn/cargoflight
        FIELDS plane_type_id, maximum_load, actual_load, load_unit,
               airport_from_id, airport_to_id, departure_time, arrival_time
         WHERE carrier_id    = @i_carrier_id
           AND connection_id = @i_connection_id
           AND flight_date   = @i_flight_date
          INTO CORRESPONDING FIELDS OF @flight_raw.
    ENDTRY.

*    carrier_id    = EXACT #( i_carrier_id ).                        " Aufgabe 6
*    connection_id = EXACT #( i_connection_id ).

    carrier_id    = i_carrier_id.
    connection_id = i_connection_id.
    flight_date   = i_flight_date.

    planetype = flight_raw-plane_type_id.
    maximum_load = flight_raw-maximum_load.
    actual_load = flight_raw-actual_load.
    load_unit = flight_raw-load_unit.

    connection_details = CORRESPONDING #( flight_raw ).

    connection_details-duration = me->connection_details-arrival_time
                                    - me->connection_details-departure_time.

  ENDMETHOD.


*  METHOD get_connection_details.                                           " Übung 19
*    r_result = me->connection_details.
*  ENDMETHOD.


  METHOD get_free_capacity.
    r_result = maximum_load - actual_load.
  ENDMETHOD.

  METHOD get_description.                                                    " Übung 19
    r_result = super->get_description(  ).

*    APPEND |Flight { carrier_id } { connection_id } on { flight_date DATE = USER } | &&
*           |from { connection_details-airport_from_id } to { connection_details-airport_to_id } |
*           TO r_result.
*    APPEND |Planetype:     { planetype } |                         TO r_result.
    APPEND |Maximum Load:  { maximum_load         } { load_unit }| TO r_result.
    APPEND |Free Capacity: { get_free_capacity( ) } { load_unit }| TO r_result.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_carrier DEFINITION .

  PUBLIC SECTION.

    INTERFACES lif_output.
    ALIASES: get_output FOR lif_output~get_output,
             t_output FOR lif_output~t_output,
             tt_output FOR lif_output~tt_output.

    DATA carrier_id TYPE /dmo/carrier_id READ-ONLY.

    METHODS constructor
      IMPORTING
                i_carrier_id TYPE /dmo/carrier_id
      RAISING   cx_abap_invalid_value
                cx_abap_auth_check_exception.


    METHODS find_passenger_flight
      IMPORTING
        i_airport_from_id TYPE /dmo/airport_from_id
        i_airport_to_id   TYPE /dmo/airport_to_id
        i_from_date       TYPE /dmo/flight_date
        i_seats           TYPE i
      EXPORTING
        e_flight          TYPE REF TO lcl_flight                              " Übung 20
        e_days_later      TYPE i.

    METHODS find_cargo_flight
      IMPORTING
        i_airport_from_id TYPE /dmo/airport_from_id
        i_airport_to_id   TYPE /dmo/airport_to_id
        i_from_date       TYPE /dmo/flight_date
        i_cargo           TYPE /lrn/plane_actual_load
      EXPORTING
        e_flight          TYPE REF TO lcl_flight                               " Übung 20
        e_days_later      TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA name          TYPE /dmo/carrier_name .
    DATA currency_code TYPE /dmo/currency_code ##NEEDED.

    DATA passenger_flights TYPE lcl_passenger_flight=>tt_flights.

    DATA cargo_flights TYPE lcl_cargo_flight=>tt_flights.

    DATA flights  TYPE lcl_flight=>tab.                                     " Übung 20

    DATA: pf_count TYPE i,                                                  " Übung 20
          cf_count TYPE i.                                                  " Übung 20


    METHODS get_average_free_seats
      RETURNING VALUE(r_result) TYPE i.

ENDCLASS.

CLASS lcl_carrier IMPLEMENTATION.

  METHOD constructor.

    me->carrier_id = i_carrier_id.

*     SELECT SINGLE                                                              " Übung 18 / 1 Kommentieren
*     FROM /dmo/carrier
**    FROM /LRN/i_carrier
**    FIELDS name, currency_code
*     FIELDS concat_with_space( carrier_id, name, 1 ), currency_code             "  Übung 11 / 6
*     WHERE carrier_id = @i_carrier_id
*     INTO ( @me->name, @me->currency_code ).

*     SELECT SINGLE                                                               " Übung 18 / 2 neue Select
*     FROM /LRN/i_carrier
*     FIELDS concat_with_space( AirlineID, name, 1 ), CurrencyCode
*     WHERE AirlineID = @i_carrier_id
*     INTO ( @me->name, @me->currency_code ).

    SELECT SINGLE                                                                " Übung 18 / 4 wieder neu
    FROM /LRN/carrier
    FIELDS concat_with_space( carrier_ID, name, 1 ), Currency_Code
    WHERE carrier_ID = @i_carrier_id
    INTO ( @me->name, @me->currency_code ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    AUTHORITY-CHECK OBJECT 'LRN/CARR'                                           " Übung 18 / 5
        ID '/LRN/CARR'  FIELD i_carrier_id
        ID 'ACTVT'      FIELD '03'.

    IF sy-subrc = 0.

      RAISE EXCEPTION TYPE cx_abap_auth_check_exception.

    ENDIF.

*    name = carrier_id && ` ` && name.                                           " Übung 11 / 5

    DATA(passenger_flights) =
        lcl_passenger_flight=>get_flights_by_carrier(
              i_carrier_id    = i_carrier_id ).

    pf_count = lines(  passenger_flights ).                                       " Übung 20

    DATA(cargo_flights) =
        lcl_cargo_flight=>get_flights_by_carrier(
              i_carrier_id    = i_carrier_id ).

    cf_count = lines(  cargo_flights ).                                          " Übung 20

    LOOP AT passenger_flights INTO DATA(passflight).
      APPEND passflight TO flights.
    ENDLOOP.

    LOOP AT cargo_flights INTO DATA(cargoflight).
      APPEND cargoflight TO flights.
    ENDLOOP.

  ENDMETHOD.

  METHOD lif_output~get_output.                                                          "Ab hier  Übung 8

    APPEND |{ 'Carrier Name:'(001) } { me->name }                         | TO r_result.
    APPEND |{ 'Passenger Flights:'(002) }  { pf_count }                   | TO r_result.
    APPEND |{ 'Average free seats:'(003) } { get_average_free_seats(  ) } | TO r_result.
    APPEND |{ 'Cargo Flights:'(004) }      { cf_count }                   | TO r_result.

  ENDMETHOD.

  METHOD find_cargo_flight.

    e_days_later = 99999999.

*    LOOP AT me->cargo_flights INTO DATA(flight)                                   " Übung 20
    LOOP AT me->flights INTO DATA(flight)
        WHERE table_line->flight_date >= i_from_date                               " Übung 20
         AND table_line IS INSTANCE OF lcl_cargo_flight.

      DATA(connection_details) = flight->get_connection_details(  ).

      IF connection_details-airport_from_id = i_airport_from_id
       AND connection_details-airport_to_id = i_airport_to_id
*       AND flight->get_free_capacity(  ) >= i_cargo.
       AND CAST lcl_cargo_flight( flight )->get_free_capacity(  )  >= i_cargo.      " Übung 20

*        DATA(days_later) =  i_from_date - flight->flight_date.
        DATA(days_later) = flight->flight_date - i_from_date.

        IF days_later < e_days_later. "earlier than previous one?
          e_flight = flight.
          e_days_later = days_later.
        ENDIF.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD find_passenger_flight.

    e_days_later = 99999999.

    LOOP AT me->flights INTO DATA(flight)
             WHERE table_line->flight_date >= i_from_date
              AND table_line IS INSTANCE OF lcl_passenger_flight.

      DATA(connection_details) = flight->get_connection_details(  ).

      IF connection_details-airport_from_id = i_airport_from_id
       AND connection_details-airport_to_id = i_airport_to_id                            " Übung 20
       AND CAST lcl_passenger_flight( flight )->get_free_seats( )
           >= i_seats.
        DATA(days_later) = flight->flight_date - i_from_date.

        IF days_later < e_days_later.
          e_flight = flight.
          e_days_later = days_later.
        ENDIF.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_average_free_seats.

*    DATA total TYPE i.                                                          " Übung 13 / 3 alles kommnetiern
*
*    LOOP AT passenger_flights INTO DATA(flight).
*
*      total = total + flight->get_free_seats( ).
*
*    ENDLOOP.
*
*    r_result = total / lines( passenger_flights ).

*    SELECT FROM /lrn/passflight                                                  " Übung 13 / 4 Aggregation
*           FIELDS
*                SUM( seats_max - seats_occupied ) AS sum,                        " Übung 14 / 4 Kommentieren
*                COUNT(*) AS count
*           WHERE carrier_id = @carrier_id
*           INTO @DATA(aggregates).
*
*   r_result = aggregates-sum / aggregates-count.

*    r_result = REDUCE #(                                                          " Übung 20
*                       INIT i = 0
*                       FOR flight IN passenger_flights
*                       NEXT i = i + flight->get_free_seats(  ) ) / lines( passenger_flights ).

    r_result =
         REDUCE #(                                                                  " Übung 20
           INIT i = 0
            FOR <flight> IN flights
          WHERE ( table_line IS INSTANCE OF lcl_passenger_flight )
           NEXT i += CAST lcl_passenger_flight( <flight> )->get_free_seats( )
         )
         / pf_count .


  ENDMETHOD.

ENDCLASS.
