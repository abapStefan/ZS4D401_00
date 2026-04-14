*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_compute DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS summe IMPORTING iv_zahl1  TYPE i
                            iv_zahl2  TYPE i
                  EXPORTING ev_result TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_compute IMPLEMENTATION.

  METHOD summe.

        ev_result = iv_zahl1 + iv_zahl2 + 1.

  ENDMETHOD.

ENDCLASS.
