CLASS zcl_40_40_up_cast_down_cast_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_40_up_cast_down_cast_1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

   DATA go_rechner TYPE REF TO lcl_rechner.    " ->Superklasse
    DATA go_rechner1 TYPE REF TO lcl_rechner1.  " -> subclass
     DATA go_rechner2 LIKE go_rechner1.


*   go_rechner1 = go_rechner.                     " funktioniert nicht

    go_rechner1 = CAST #( go_rechner ).

    go_rechner = NEW #(  ).
     out->write( 'Implizierter UPCAST mit NEW' ).
     out->write( go_rechner->a ).
     out->write( go_rechner->b ).
     out->write( go_rechner->c ).
     out->write( '-----------------------------------' ).

    CREATE OBJECT go_rechner1.     " Instanz muss ert mal erstellt werden

    go_rechner = go_rechner1.   " Upcast

      go_rechner->a = 'a'.     "  Nur a b und c zu sehen
      go_rechner->b = 'b'.
      go_rechner->c = 'd'.

    out->write( 'UPCAST' ).
     out->write( go_rechner->a ).
     out->write( go_rechner->b ).
     out->write( go_rechner->c ).
     out->write( '-----------------------------------' ).


    if go_rechner2 is INSTANCE OF lcl_rechner.  " Sicherer Downcast: Um Laufzeitfehler zu vermeiden,
                                                " sollte geprüft werden, ob der Cast möglich ist,
                                                " z.B. durch IF go_rechner2 IS INSTANCE OF lcl_rechner.

    go_rechner2 ?= go_rechner.    " Downcast


    ENDIF.

       go_rechner2->a = 'a'.
       go_rechner2->b = 'b'.
       go_rechner2->c = 'c'.
       go_rechner2->e = 'e'.


   out->write( 'Downcast' ).
     out->write( go_rechner2->a ).
     out->write( go_rechner2->b ).
     out->write( go_rechner2->c ).
     out->write( go_rechner2->e ).
     out->write( '-----------------------------------' ).





  ENDMETHOD.
ENDCLASS.
