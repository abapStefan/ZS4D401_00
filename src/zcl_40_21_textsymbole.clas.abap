CLASS zcl_40_21_textsymbole DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_21_textsymbole IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  out->write( 'Employee' ).     " Textliteral keine Änderung möglich
  out->write(  Text-001 ).      " mit strg + 1 kann auch der Text geladen werden hier

  out->write( cl_abap_context_info=>get_system_date(  ) ).
  out->write(  'Manager'(mng) ). " übnersichtlicher

  out->write( 'Hello World'(hwd) ).

  ENDMETHOD.
ENDCLASS.
