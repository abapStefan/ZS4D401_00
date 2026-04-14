*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_super1 definition.

  public section.

      CLASS-METHODS class_constructor.

      METHODS constructor IMPORTING i_a TYPE i.

      CLASS-DATA table TYPE TABLE OF string.

      DATA m_a TYPE i.
  protected section.
  private section.

endclass.

class lcl_super1 implementation.

  method class_constructor.

     DATA text TYPE string VALUE '1 Classconstruktor der Oberklasse aufgerufen'.
     APPEND text to table.

  endmethod.

  method constructor.

  DATA text TYPE string VALUE '4 Instanzconstruktor der Oberklasse aufgerufen'.
     APPEND text to table.

  endmethod.

endclass.

class lcl_sub1 definition INHERITING FROM lcl_super1.

  public section.

     CLASS-METHODS class_constructor.

     METHODS constructor.



  protected section.
  private section.

endclass.

class lcl_sub1 implementation.


  method class_constructor.

    DATA text TYPE string VALUE '2 Classconstruktor der Unterklasse aufgerufen'.
    APPEND text to table.

  endmethod.

  method constructor.

    super->constructor( i_a = m_a ).

     DATA text TYPE string VALUE '3 Instanzconstruktor der Unterklasse aufgerufen'.
     APPEND text to table.


  endmethod.

endclass.
