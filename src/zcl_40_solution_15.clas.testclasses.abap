*"* use this source file for your ABAP unit test classes

class ltcl_find_flight definition final for testing
  duration LONG
  risk level harmless.

  private section.
    methods:
      test_find_cargo_flight for testing raising cx_static_check.
endclass.


class ltcl_find_flight implementation.

  method test_find_cargo_flight.

     SELECT SINGLE
         FROM /lrn/cargoflight
         FIELDS carrier_id, connection_id, flight_date,
                airport_from_id, airport_to_id
         INTO @DATA(some_flight_data).

    IF sy-subrc <> 0.

    cl_abap_unit_assert=>fail( 'Keine Daten in der Tabelle /LRN/CARGOFLIGHT' ).

    ENDIF.

    TRY.

        DATA(the_carrier) = NEW lcl_carrier( i_carrier_id = some_flight_data-carrier_id ).

        CATCH cx_abap_invalid_value.
        cl_abap_unit_assert=>fail( 'lcl_carrier kann nicht Instanziiert werden' ).

    ENDTRY.

    the_carrier->find_cargo_flight(
          EXPORTING
           i_airport_from_id = some_flight_data-airport_from_id
           i_airport_to_id = some_flight_data-airport_to_id
           i_from_date = some_flight_data-flight_date
           i_cargo = 1

          IMPORTING

          e_flight = DATA(flight)
          e_days_later = DATA(days_later)
          ).

          cl_abap_unit_assert=>assert_bound(
                  act = flight
                  msg = 'Die Methode find_cargo_flight leifert kein Ergebnis' ).

          cl_abap_unit_assert=>assert_equals(
                  act = days_later
                  exp = 0
                  msg = 'Die Methode find_cargo_flight liefert falsches Ergebnis ' ).





  endmethod.

endclass.
