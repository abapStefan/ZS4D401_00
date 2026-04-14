*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_vehicle definition.

  public section.

     DATA a VALUE 'a'.
     DATA b VALUE 'b'.
     DATA c VALUE 'c'.

     METHODS get_make RETURNING VALUE(r_make) TYPE string_table.
     METHODS get_count RETURNING VALUE(r_count) TYPE string_table.

  protected section.
  private section.

     DATA d VALUE 'd'.

endclass.

class lcl_vehicle IMPLEMENTATION.

  METHOD get_count.

    DATA test TYPE string VALUE 'get_count'.

  ENDMETHOD.

  METHOD get_make.

  DATA test TYPE string VALUE 'get_make'.

  ENDMETHOD.

ENDCLASS.

class lcl_truck DEFINITION INHERITING FROM lcl_vehicle.

  PUBLIC SECTION.

     DATA e VALUE 'e'.

     METHODS get_cargo RETURNING VALUE(r_cargo) TYPE string_table.

  PRIVATE SECTION.

     DATA f VALUE 'f'.

endclass.

class lcl_truck IMPLEMENTATION.

METHOD get_cargo .

DATA test TYPE string VALUE 'get_cargo'.

ENDMETHOD.

ENDCLASS.
