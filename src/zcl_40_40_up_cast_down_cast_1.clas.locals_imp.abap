*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_rechner definition.

  public section.

     DATA a VALUE 'a'.
     DATA b VALUE 'b'.
     DATA c VALUE 'c'.

  protected section.
  private section.

     DATA d VALUE 'd'.

endclass.

class lcl_rechner1 DEFINITION INHERITING FROM lcl_rechner.

  PUBLIC SECTION.

     DATA e VALUE 'e'.

  PRIVATE SECTION.

     DATA f VALUE 'f'.

endclass.
