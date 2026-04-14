*"* use this source file for your ABAP unit test classes

CLASS ltcl_1 DEFINITION FINAL FOR TESTING
                        DURATION SHORT
                        RISK LEVEL HARMLESS.
  PUBLIC SECTION.
    CLASS-METHODS class_constructor.

  PRIVATE SECTION.
    METHODS:
      test_summe_1 FOR TESTING RAISING cx_static_check.

    METHODS:
      test_summe_2 FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_1 IMPLEMENTATION.

  METHOD class_constructor.

   DATA a.
   a = a.

  ENDMETHOD.

  METHOD test_summe_1.

     DATA lo_compute TYPE REF TO lcl_compute.

     CREATE OBJECT lo_compute.

     IF lo_compute IS INITIAL.

      cl_abap_unit_assert=>fail( 'Fehler in der Instanzierung' ).

     ENDIF.

     lo_compute->summe(
          EXPORTING
              iv_zahl1 = 10
              iv_zahl2 = 20
           IMPORTING
              ev_result = DATA(lv_result) ).

      cl_abap_unit_assert=>assert_equals(
                EXPORTING
                act   = lv_result
                exp   = 30
*               ignore_hash_sequence
*               tol
*               msg
*               level = if_abap_unit_constant=>severity-medium
*               quit  = if_abap_unit_constant=>quit-test
*               RECEIVING
*               assertion_failed =
         ).


  ENDMETHOD.

  METHOD test_summe_2.

      DATA lo_compute TYPE REF TO lcl_compute.

     CREATE OBJECT lo_compute.

     IF lo_compute IS INITIAL.

      cl_abap_unit_assert=>fail( 'Fehler in der Instanzierung' ).

     ENDIF.

     lo_compute->summe(
          EXPORTING
              iv_zahl1 = 50
              iv_zahl2 = 100
           IMPORTING
              ev_result = DATA(lv_result) ).

      cl_abap_unit_assert=>assert_equals(
                EXPORTING
                act   = lv_result
                exp   = 151
*               ignore_hash_sequence
*               tol
*               msg
*               level = if_abap_unit_constant=>severity-medium
*               quit  = if_abap_unit_constant=>quit-test
*               RECEIVING
*               assertion_failed =
         ).

  ENDMETHOD.

ENDCLASS.
