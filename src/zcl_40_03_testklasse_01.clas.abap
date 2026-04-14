CLASS zcl_40_03_testklasse_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_03_testklasse_01 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.
*  CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'XX'.

    TRY.

       DATA(carrier) = lcl_data=>get_carrier( i_carrier_id = c_carrier_id ).

       out->write( carrier ).

     CATCH cx_abap_invalid_value.
     out->write( |Carrier { c_carrier_id } existiert nicht| ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
