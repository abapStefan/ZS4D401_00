CLASS zcl_40_35_authority_check DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_35_authority_check IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    AUTHORITY-CHECK OBJECT '/DMO/TRVL'
                    ID '/DMO/CNTRY' FIELD  'US'
                    ID 'ACTVT' FIELD '03'.

    AUTHORITY-CHECK OBJECT '/DMO/TRVL'
                        ID '/DMO/CNTRY' FIELD  'DE'
                        ID 'ACTVT' FIELD '03'.



    IF sy-subrc = 0.
      out->write( |Anzeigeberechtigung für das Land 'US'| ).
    ELSE.
      out->write( |Keine Anzeigeberechtigung für das Land 'US'| ).
    ENDIF.

**********************************************************************
    out->write( `-----------------------------------------------------------` ).

    AUTHORITY-CHECK OBJECT '/DMO/TRVL'
                    ID '/DMO/CNTRY' FIELD  'ZW'
                    ID 'ACTVT' FIELD '03'.

    IF sy-subrc <> 0.
      out->write( |Anzeigeberechtigung für das Land 'ZW'| ).
    ELSE.
      out->write( |Keine Anzeigeberechtigung für das Land 'ZW'| ).
    ENDIF.

**********************************************************************
    out->write( `-----------------------------------------------------------` ).

    SELECT FROM /lrn/airport
      FIELDS airport_id, name, country
      INTO TABLE @DATA(airports).

    out->write( |Gesamtzahl der Flughäfen:         { lines( airports ) }| ).

    LOOP AT airports ASSIGNING FIELD-SYMBOL(<airp>).

      AUTHORITY-CHECK OBJECT '/DMO/TRVL'
                      ID '/DMO/CNTRY' FIELD  <airp>-country
                      ID 'ACTVT' FIELD '03'.

      IF sy-subrc <> 0.
        DELETE airports INDEX sy-tabix.
      ENDIF.

    ENDLOOP.

    out->write( |Flughäfen nach Authority Check:   { lines( airports ) }| ).

    SORT airports BY country.

    out->write( airports ).


  ENDMETHOD.
ENDCLASS.
