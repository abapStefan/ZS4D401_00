CLASS zcl_40_solution_26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_40_SOLUTION_26 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

     CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'BB'.
*     CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'UA'.                        " Übung 18 / 3

    TRY.
*        DATA(carrier) = NEW lcl_carrier(  i_carrier_id = c_carrier_id ).           " Übung 23 funktioniert nicht mehr
         DATA(carrier) = lcl_carrier=>get_instance( i_carrier_id = c_carrier_id ).  " Übung 23 jetzt funktionert es wieder

         DATA(carrier2) = lcl_carrier=>get_instance( i_carrier_id = c_carrier_id ). " Übung 23 / letzte Aufgabe

        out->write(  name = `Carrier Overview`
                     data = carrier->get_output(  ) ).

*      CATCH cx_abap_invalid_value INTO DATA(exc_inv).                                   " Übung 24  / Übung 25 letzte kommentieren
**        out->write( | Carrier { c_carrier_id } does not exist | ).                     " Übung 24
*         out->write( exc_inv->get_text( ) ).                                            " Übung 24
*
*      CATCH cx_abap_auth_check_exception INTO DATA(exc_auth).                           " Übung 24
*
**        out->write( |Keine Berechtigung für die Fluggesellschaft { c_carrier_id } | ).
*        out->write( exc_auth->get_text( ) ).                                            " Übung 24

              CATCH zcx_40_failed INTO DATA(exc_fail).                                   " Übung 25
               out->write( exc_fail->get_text( ) ).

    ENDTRY.

    IF carrier IS BOUND.

      out->write(  `--------------------------------------------------` ).

* Find a passenger flight from Frankfurt to New York
* starting as soon as possible after tomorrow
* with at least 5 free seats

      DATA(today) = cl_abap_context_info=>get_system_date(  ).

      carrier->find_passenger_flight(
         EXPORTING
           i_airport_from_id = 'FRA'
           i_airport_to_id   = 'JFK'
           i_from_date       = today
           i_seats           = 5
         IMPORTING
           e_flight =     DATA(pass_flight)
           e_days_later = DATA(days_later)
                         ).

      IF pass_flight IS BOUND.
        out->write( name = |Found a suitable passenger flight in { days_later } days:|
*                    data = pass_flight->get_description( ) ).
*                      data = pass_flight->lif_output~get_output( ) ).                        " Übung 22 / 5
                       data = pass_flight->get_output( ) ).                                   " Übung 21 / 8 nach Alias
      ELSE.
        out->write( data = `No Passenger Flight found` ).
      ENDIF.

      out->write(  `--------------------------------------------------` ).

** Find a cargo flight from Frankfurt to New York
** starting as soon as possible but earliest in 7 days
** with at least 1200 KG free capacity
*
      carrier->find_cargo_flight(
         EXPORTING
           i_airport_from_id = 'FRA'
           i_airport_to_id   = 'JFK'
           i_from_date       = today
           i_cargo           = 1200
         IMPORTING
           e_flight =     DATA(cargo_flight)
           e_days_later = DATA(days_later2)
                         ).

      IF cargo_flight IS BOUND.
        out->write( name = |Found a suitable cargo flight in { days_later2 } days:|
*                    data = cargo_flight->get_description( ) ).
*                      data = cargo_flight->lif_output~get_output( ) ).                       " Übung 22 / 6
                       data = cargo_flight->get_output( ) ).                                  " Übung 22 / 9 nach Alias
      ELSE.
        out->write( data = `No cargo flight found` ).
      ENDIF.



    ENDIF.

  ENDMETHOD.
ENDCLASS.
