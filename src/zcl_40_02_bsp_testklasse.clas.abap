CLASS zcl_40_02_bsp_testklasse DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_02_bsp_testklasse IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA lo_compute TYPE REF TO lcl_compute.    " Dies ist ein Programm wo eine zahl plus einer anderen addiert werden

  CREATE OBJECT lo_compute.

  lo_compute->summe(
        EXPORTING
            iv_zahl1 = 10
            iv_zahl2 = 20
       IMPORTING
            ev_result = DATA(lv_result) ).

            out->write( lv_result ).

  ENDMETHOD.
ENDCLASS.
