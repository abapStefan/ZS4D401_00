CLASS zcl_40_04_testklasse_mit_setup DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_04_testklasse_mit_setup IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.
  CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'XX'.

    TRY.

       DATA(carrier) = new lcl_carrier( c_carrier_id ).

       out->write( | Carrier { carrier->get_name(  ) } hat Currency { carrier->get_currency(  ) } | ).

     CATCH cx_abap_invalid_value.
     out->write( |Carrier { c_carrier_id } existiert nicht| ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
