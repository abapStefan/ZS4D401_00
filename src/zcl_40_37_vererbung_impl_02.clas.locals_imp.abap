*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_fahrzeuge DEFINITION.

  PUBLIC SECTION.

    TYPES: BEGIN OF fs_attribute,     " Lokale Struktur erstellen
             fahrzeugdaten TYPE string,
             wert          TYPE string,
           END OF fs_attribute.

    TYPES ft_attribute TYPE SORTED TABLE OF fs_attribute WITH UNIQUE KEY fahrzeugdaten.    " Tabelle deklarieren

    METHODS constructor                        " Constructor Methode erstellen
      IMPORTING i_hersteller TYPE string
                i_typ        TYPE string
                i_ps         TYPE i.

    METHODS get_attributes RETURNING VALUE(rt_attribute) TYPE ft_attribute.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA hersteller TYPE string.       " Attribute erzeugen
    DATA typ        TYPE string.
    DATA ps         TYPE i.

ENDCLASS.

CLASS lcl_fahrzeuge IMPLEMENTATION.

  METHOD constructor.

    hersteller = i_hersteller.
    typ        = i_typ.
    ps         = i_ps.

  ENDMETHOD.

  METHOD get_attributes.

    rt_attribute = VALUE #( ( fahrzeugdaten = 'Hersteller' wert = hersteller )
                            ( fahrzeugdaten = 'Typ'        wert = typ )
                            ( fahrzeugdaten = 'PS'         wert = ps ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lcl_lkw DEFINITION INHERITING FROM lcl_fahrzeuge.    " LKW erbt alles aus der Oberklasse


ENDCLASS.

CLASS lcl_lkw IMPLEMENTATION.

ENDCLASS.
