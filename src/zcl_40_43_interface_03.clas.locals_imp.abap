*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

INTERFACE lif_partner.

DATA name Type string.
METHODS get_make RETURNING VALUE(r_make) TYPE string_table.

ENDINTERFACE.


class lcl_partner DEFINITION.

  PUBLIC SECTION.

  INTERFACES lif_partner.

ENDCLASS.

class lcl_partner IMPLEMENTATION.

  METHOD lif_partner~get_make.

  ENDMETHOD.

ENDCLASS.

class lcl_rental DEFINITION.

  PUBLIC SECTION.

     INTERFACES lif_partner.
     ALIASES aha for lif_partner~name.     " Hier ein Alias erstellen

     METHODS constructor IMPORTING iv_name TYPE string.

     DATA mv_name TYPE string.

ENDCLASS.

class lcl_rental IMPLEMENTATION.

  METHOD constructor.
        mv_name = iv_name.
  ENDMETHOD.

  METHOD lif_partner~get_make.

  ENDMETHOD.

ENDCLASS.

class lcl_carrier DEFINITION.

  PUBLIC SECTION.

     INTERFACES lif_partner.

     METHODS constructor IMPORTING iv_name TYPE string.

     DATA mv_name TYPE string.

ENDCLASS.

class lcl_carrier IMPLEMENTATION.

  METHOD constructor.
        mv_name = iv_name.
  ENDMETHOD.

  METHOD lif_partner~get_make.

  ENDMETHOD.

ENDCLASS.
