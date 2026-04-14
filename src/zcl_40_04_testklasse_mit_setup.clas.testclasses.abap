*"* use this source file for your ABAP unit test classes
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS setup.

    METHODS: test_get_name FOR TESTING.

    METHODS: test_get_currency FOR TESTING.

    DATA carrier TYPE REF TO lcl_carrier.

ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.  " Wird vor jeder Testmethode ausgeführt

* Lese eine beliebige Carrier aus der Datenbank
    SELECT SINGLE
          FROM /dmo/carrier
          FIELDS carrier_id
          INTO @DATA(carrier_id).

    IF sy-subrc <> 0.
      cl_abap_unit_assert=>skip(
            msg =  'Keine Daten in /DMO/Carrier'
         detail = 'Für den Test ist mindestens ein Eintrag erforderlich in der DB' ).
    ENDIF.

* Jetzt die zu testende Instanz erstellen
***************************************************************************

TRY.
      me->carrier  = new lcl_carrier( carrier_id ).

      CATCH cx_abap_invalid_value.

      cl_abap_unit_assert=>fail(
             msg = 'Kann keine Instanz erstellen von lcl_carrier'
             detail = 'Constructor von lcl_carrier löst eine Ausnahme aus, obwohl die nicht vorgesehen war'  ).

 ENDTRY.

      cl_abap_unit_assert=>assert_bound(
                 act = me->carrier
                 msg = 'Kann keine Instanz von lcl_carrier erstellen' ).


  ENDMETHOD.

  METHOD test_get_name.


    DATA(name) = me->carrier->get_name(  ).

    cl_abap_unit_assert=>assert_not_initial(
             act = name
             msg = 'Ergebnis der Methode get_name'
             quit  = if_abap_unit_constant=>quit-no
).

* Kompakte Alternative ( Ohne Hilfsvariablen )

*      cl_abap_unit_assert=>assert_not_initial(
*             act = me->carrier->get_name(  )
*             msg = 'Ergebnis der Methode get_name'
*             quit  = if_abap_unit_constant=>quit-no

ENDMETHOD.

METHOD test_get_currency.

cl_abap_unit_assert=>assert_not_initial(
             act = me->carrier->get_currency(  )
             msg = 'Ergebnis der Methode get_name'
             quit  = if_abap_unit_constant=>quit-no ).

ENDMETHOD.


ENDCLASS.
