*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_fahrzeuge definition.

  public section.

       TYPES: Begin OF fs_attribute,     " Lokale Struktur erstellen
              name TYPE STRING,
              value TYPE string,
              END of fs_attribute.

        TYPES ft_attribute TYPE SORTED TABLE OF fs_attribute with UNIQUE KEY name.    " Tabelle deklarieren


        METHODS constructor                        " Constructor Methode erstellen
                importing i_hersteller TYPE string
                          i_typ        TYPE string.

        METHODS get_attributes RETURNING VALUE(rt_attribute) TYPE ft_attribute.

  protected section.

  private section.

       DATA hersteller TYPE string.       " Attribute erzeugen
       DATA typ        TYPE string.

endclass.

class lcl_fahrzeuge implementation.

  method constructor.

       hersteller = i_hersteller.
       typ        = i_typ.

  endmethod.

  method get_attributes.

         rt_attribute = VALUE #( ( name = 'Hersteller' value = hersteller )
                                 ( name = 'Typ'        value = typ ) ).

  endmethod.

endclass.
