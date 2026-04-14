CLASS zcl_40_46_ausnahmeklassen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_46_ausnahmeklassen IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA number1 TYPE i VALUE 2000000000.
    DATA number2 TYPE p LENGTH 2 DECIMALS 1 VALUE '0.5'.
    DATA result TYPE i.


*    TRY.
**
**
*        result = number1 / number2.
**
**
*      CATCH cx_sy_arithmetic_overflow.
*        out->write( 'Arithmetic Overflow' ).
*      CATCH cx_sy_zerodivide.
*        out->write( 'Division by zero' ).
*    ENDTRY.


    number2 = 0.
*    TRY.
*
*
*        result = number1 / number2.
*
*
*      CATCH cx_sy_arithmetic_overflow.
*        out->write( 'Arithmetic Overflow' ).
*      CATCH cx_sy_zerodivide.
*        out->write( 'Division by zero' ).
*    ENDTRY.
*
*    TRY.
*        result = number1 / number2.
*
*
*      CATCH cx_sy_arithmetic_overflow cx_sy_zerodivide.
*        out->write( 'Arithmetic overflow or division by zero' ).
*    ENDTRY.
*
*    TRY.
*        result = number1 / number2.
*      CATCH cx_sy_arithmetic_error.
*        out->write( 'Beide Ausnahmen wurden mithilfe ihrer gemeinsamen Oberklasse abgefangen' ).
*    ENDTRY.
*
*
*    TRY.
*        result = number1 / number2.
*      CATCH cx_root.
*        out->write( 'Mit CX_ROOT wurde ein Ausnahme abgefangen' ).
*    ENDTRY.
**
*
    TRY.
        result = number1 / number2.
      CATCH cx_root INTO DATA(Exception).
        out->write( 'INTO verwendet, um das Ausnahmeobjekt abzufangen' ).
        out->write( 'Die Methode get_text( ) gibt folgenden Fehlertext zurück: ' ).
        out->write( Exception->get_text( ) ).
    ENDTRY.


  ENDMETHOD.
ENDCLASS.
