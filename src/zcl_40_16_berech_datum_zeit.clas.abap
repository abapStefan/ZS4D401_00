CLASS zcl_40_16_berech_datum_zeit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_16_berech_datum_zeit IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Klasse cl_abap_context_info

    DATA var_date TYPE d.
    DATA var_time TYPE t.
    DATA var_time_zone TYPE c LENGTH 6.


*   var_date = '20260319'.
*   var_time = '110000'.

    var_date = cl_abap_context_info=>get_system_date(  ).
    var_time = cl_abap_context_info=>get_system_time(  ).
    var_time_zone = cl_abap_context_info=>get_user_time_zone(  ).


   out->write( var_date ).
   out->write( var_time ).
   out->write( var_time_zone ).








  ENDMETHOD.
ENDCLASS.
