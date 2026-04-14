CLASS zcl_40_38_vererbung_impl_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_38_vererbung_impl_03 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA fahrzeuge TYPE REF TO lcl_fahrzeuge.
  DATA lkw       TYPE REF TO lcl_lkw.

  lkw = new #( i_hersteller = 'MAN'
               i_typ        = 'TGX'
               i_ps         = 400
               i_ladung     = 40000 ).


    out->write(  'Ausgabe mit Objektreferenz LKW bis hier nur geerbte Methoden aus der Oberklasse' ).
    out->write(  lkw->get_attributes(  ) ).
    out->write( '--------------------------------------------------------------------------' ).


  ENDMETHOD.
ENDCLASS.
