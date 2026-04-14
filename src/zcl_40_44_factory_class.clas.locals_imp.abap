*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

class lcl_connection definition create private.    " WICHTIG Create Privat " kein NEW ausserhalb der Klasse

  public section.

      METHODS constructor
               IMPORTING
                   AirlineID TYPE /dmo/carrier_id
                   ConnectionNumber TYPE /dmo/connection_id
                   FromAirport TYPE /dmo/airport_from_id
                   ToAirport TYPE /dmo/airport_to_id.

      METHODS get_attribute RETURNING VALUE(rt_result) TYPE string_table.

      CLASS-Methods get_connection             " statische Factory Methode
                        IMPORTING
                           AirlineID TYPE /dmo/carrier_id
                    ConnectionNumber TYPE /dmo/connection_id RETURNING VALUE(ro_connection) TYPE REF TO lcl_connection.

      CLASS-METHODS get_n_o_connections RETURNING VALUE(rv_count) TYPE i.

      CLASS-DATA gv_n_o_connections TYPE i.


  protected section.


  private section.

       DATA AirlineID TYPE /dmo/carrier_id.
       DATA ConnectionNumber TYPE /dmo/connection_id.
       DATA FromAirport TYPE /dmo/airport_from_id.
       DATA ToAirport TYPE /dmo/airport_to_id.

endclass.

class lcl_connection implementation.

  method constructor.

     me->airlineid = airlineid.
     me->connectionnumber = connectionnumber.
     me->fromairport = fromairport.
     me->toairport = toairport.

     gv_n_o_connections = gv_n_o_connections + 1.

  endmethod.

  method get_connection.

    DATA fromAirport TYPE /dmo/airport_from_id.
    DATA ToAirport TYPE /dmo/airport_to_id.

    SELECT SINGLE FROM /dmo/connection
    FIELDS airport_from_id, airport_to_id
    WHERE carrier_id = @AirlineId
    AND connection_id = @connectionnumber
    INTO (  @fromAirport, @toairport ).

    ro_connection = NEW #( airlineid = airlineid
                           connectionnumber = connectionnumber
                           fromairport = fromairport
                           toairport = toairport ).

  endmethod.

  method get_n_o_connections.

  rv_count = gv_n_o_connections.

  endmethod.

  method get_attribute.

   APPEND |Fluggesellschaft: { me->airlineid }     | TO rt_result.
   APPEND |Carrid: { me->connectionnumber }        | TO rt_result.
   APPEND |Abflughafen: { me->fromairport }        | TO rt_result.
   APPEND |Zielfluhafen: { me->toairport }         | TO rt_result.
   APPEND |----------------------------------------| TO rt_result.


  endmethod.


endclass.
