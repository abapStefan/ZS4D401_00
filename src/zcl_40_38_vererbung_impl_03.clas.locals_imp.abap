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

    METHODS get_attributes RETURNING value(rt_attribute) TYPE ft_attribute.



  PROTECTED SECTION.

    DATA hersteller TYPE string. " Attribute erzeugen
    DATA typ        TYPE string.
    DATA ps         TYPE i.


  PRIVATE SECTION.




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

      PUBLIC SECTION.

      METHODS constructor      " Neuer Constructor für die Unterklasse mit neuem Attribute erstellt

              IMPORTING i_hersteller TYPE string
                        i_typ        TYPE string
                        i_ps         TYPE i
                        i_ladung     TYPE p.

       METHODS get_attributes REDEFINITION.                  " Methode wird Redefiniert

      PRIVATE SECTION.

      DATA ladung TYPE p DECIMALS 2.    " Neue Eigenschaft des LKWs



ENDCLASS.

CLASS lcl_lkw IMPLEMENTATION.

  METHOD constructor.

    super->constructor( i_hersteller = i_hersteller
                        i_typ = i_typ
                        i_ps = i_ps ).

    ladung = i_ladung.                  " Neues Attribut hinzufügen

  ENDMETHOD.

  METHOD get_attributes.

* Option 1 Redefinition verwendet geschützten Attribute der Oberklasse


    rt_attribute = VALUE #( ( fahrzeugdaten = 'Hersteller' wert = hersteller )
                            ( fahrzeugdaten = 'Typ'        wert = typ )
                            ( fahrzeugdaten = 'PS'         wert = ps )
                            ( fahrzeugdaten = 'Ladung'     wert = ladung ) ).


  ENDMETHOD.

ENDCLASS.
