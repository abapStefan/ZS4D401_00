CLASS zcl_40_39_vererbung_impl_04 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_39_vererbung_impl_04 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA fahrzeuge TYPE REF TO lcl_fahrzeuge.
  DATA lkw       TYPE REF TO lcl_lkw.
  DATA bus       TYPE REF TO lcl_bus.

  lkw = new #( i_hersteller = 'MAN'
               i_typ        = 'TGX'
               i_ps         = 400
               i_ladung     = 40000 ).


    out->write(  'Ausgabe mit Objektreferenz LKW ' ).
    out->write(  lkw->get_attributes(  ) ).
    out->write( '--------------------------------------------------------------------------' ).

 bus = new #( i_hersteller = 'TEMSA'
              i_typ        = 'MD9'
              i_ps         =  337
              i_sitze      = 40  ).

    out->write(  'Ausgabe mit Objektreferenz bus ' ).
    out->write(  bus->get_attributes(  ) ).
    out->write( '--------------------------------------------------------------------------' ).






  ENDMETHOD.
ENDCLASS.
