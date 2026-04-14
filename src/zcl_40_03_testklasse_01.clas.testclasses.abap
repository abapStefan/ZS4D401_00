*"* use this source file for your ABAP unit test classes
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS: test_sucess FOR TESTING.

    METHODS: test_exception FOR TESTING.

ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD test_sucess.

* Vorbereitung: Eine beliebige carrier_id aus der Datenbank auslesen
*************************************************************************

    SELECT SINGLE
          FROM /dmo/carrier
          FIELDS carrier_id
          INTO @DATA(carrier_id).

    IF sy-subrc <> 0.
      "    Keine Daten in der Tabelle /dmo/carrier, stop testing
      cl_abap_unit_assert=>fail( 'Für den Test ist mindestens ein eintrag in DB Tabelle /DMO/CARRIER erfoderlich' ).
    ENDIF.

* Jetzt führen wir den Methodentest durch lcl_data=>get_carrier( ).
***************************************************************************

TRY.
      DATA(carrier) = lcl_data=>get_carrier( carrier_id ).

      CATCH cx_abap_invalid_value.

      cl_abap_unit_assert=>fail(
             msg = 'Unzulässige Ausnahme'
*             level = if_abap_unit_constant=>severity-medium
*             quit  = if_abap_unit_constant=>quit-test
             detail = 'Methode lcl_data=>carrier( ) löst eine Ausnahme aus, obwohl die nicht vorgesehen war'  ).

      DATA var1 TYPE i.

      DATA var2 TYPE i.

      cl_abap_unit_assert=>assert_equals(
                   act   = var1
                   exp   = var2
*            tol   =
*            msg   = ''Eine kurzmeldung hier
*            level = if_abap_unit_constant=>severity-medium
*            quit  = if_abap_unit_constant=>quit-test
).

      cl_abap_unit_assert=>fail(
             msg = 'Hier eine kurzen Text eingeben'
             level = if_abap_unit_constant=>severity-medium
             quit  = if_abap_unit_constant=>quit-test
             detail = 'Optional eine längere Erklärung' ).

      ENDTRY.



  ENDMETHOD.

  METHOD test_exception.

* Hier geben wir eine carrier_id an, die (hoffentlich) noch nicht in der Datenbank vorahnden ist
************************************************************************************************

     CONSTANTS c_wrong_carrier_id TYPE /dmo/carrier_id VALUE 'XX'.

* Vorbereitung : Hier stellen wir sicher, das der carrier nicht in der Datenbank vorhanden ist
***********************************************************************************************

      SELECT SINGLE
          FROM /dmo/carrier
          FIELDS carrier_id
          WHERE carrier_id = 'XX'
          INTO @DATA(carrier_id).

    IF sy-subrc = 0.
       " Carrier existiert in der DB Tabelle /DMO/carrier, stop Testing
       cl_abap_unit_assert=>fail(
             msg = |Carrier { c_wrong_carrier_id } existiert in /DMO/Carrier|
             level = if_abap_unit_constant=>severity-high
             quit  = if_abap_unit_constant=>quit-test
             detail = 'Wenn DB Tabelle /DMO/CARRIER einen Eintrag enthält' &&
                      |mit Carrier_id = '{ c_wrong_carrier_id }'| &&
                       'Ist es nicht möglich die Ausnahme zu prüfen' ).
    ENDIF.

* Dann führen wir den Test der Methode lcl_data=>get_carrier( ) durch

  TRY.
    DATA(carrier) = lcl_data=>get_carrier( carrier_id ).

     cl_abap_unit_assert=>fail(
             msg = 'Keine Fehler'
*             level = if_abap_unit_constant=>severity-high
*             quit  = if_abap_unit_constant=>quit-test
             detail = 'Methode lcl_data=>carrier( ) löst eine Ausnahme aus, obwohl sie dies nicht tun sollte' ).

       catch cx_abap_invalid_value.

   ENDTRY.


  ENDMETHOD.

ENDCLASS.
