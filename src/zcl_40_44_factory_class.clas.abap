CLASS zcl_40_44_factory_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_44_factory_class IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA connection TYPE REF TO lcl_connection.
  DATA t_connections TYPE TABLE OF REF TO lcl_connection.
  DATA gv_count.

*  ro_connection = NEW lcl_connection( airlineid = 'LH'                       " NEW Das funktioniert bei einer Factory Methode nicht
*                                      connectionnumber = '0400' ).

 connection = lcl_connection=>get_connection( airlineid = 'LH'
                                              connectionnumber = '0400' ).

 APPEND connection to t_connections.

 connection = lcl_connection=>get_connection( airlineid = 'LH'
                                              connectionnumber = '0400' ).

 APPEND connection to t_connections.

 LOOP AT t_connections INTO connection.

 out->write( connection->get_attribute(  ) ).

 ENDLOOP.

 out->write( |Es wurden dennoch| && | | && lcl_connection=>get_n_o_connections(  ) && | | && |Instanzen erstellt| ).


  ENDMETHOD.
ENDCLASS.
