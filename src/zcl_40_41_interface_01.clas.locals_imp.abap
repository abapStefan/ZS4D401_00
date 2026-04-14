*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_partner DEFINITION.

  PUBLIC SECTION.

ENDCLASS.

class lcl_partner IMPLEMENTATION.

ENDCLASS.

class lcl_rental DEFINITION.

  PUBLIC SECTION.

     METHODS constructor IMPORTING iv_name TYPE string.

     DATA mv_name TYPE string.

ENDCLASS.

class lcl_rental IMPLEMENTATION.

  METHOD constructor.
        mv_name = iv_name.
  ENDMETHOD.

ENDCLASS.

class lcl_carrier DEFINITION.

  PUBLIC SECTION.

     METHODS constructor IMPORTING iv_name TYPE string.

     DATA mv_name TYPE string.

ENDCLASS.

class lcl_carrier IMPLEMENTATION.

  METHOD constructor.
        mv_name = iv_name.
  ENDMETHOD.

ENDCLASS.
