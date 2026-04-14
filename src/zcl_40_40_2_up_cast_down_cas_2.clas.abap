CLASS zcl_40_40_2_up_cast_down_cas_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_40_2_up_cast_down_cas_2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

   DATA go_vehicle TYPE REF TO lcl_vehicle.    " ->Superklasse
    DATA go_truck TYPE REF TO lcl_truck.  " -> subclass
     DATA go_truck2 LIKE go_truck.


*   go_vehicle = NEW #(  ).
*
*    go_truck = cast #( go_vehicle ).



   create object go_truck.

        go_truck->a = 'a'.
        go_truck->a = 'b'.
        go_truck->a = 'c'.
        go_truck->a = 'e'.
        go_truck->get_cargo(  ).
        go_truck->get_count(  ).
        go_truck->get_make(  ).


       go_vehicle = go_truck.       " Upcast / kein Zugriff auf öffentliche Komponenten  go_cargo aus lcl truck


       go_vehicle->a = 'a'.         " Sicht wird eingeengt
       go_vehicle->b = 'b'.
       go_vehicle->c = 'c'.
       go_vehicle->get_count(  ).
       go_vehicle->get_make(  ).


       if go_truck2 is INSTANCE OF lcl_vehicle.  " Sicherer Downcast: Um Laufzeitfehler zu vermeiden,
                                                 " sollte geprüft werden, ob der Cast möglich ist,
                                                 " z.B. durch IF go_truck2 IS INSTANCE OF lcl_vehicle.

       go_truck2 ?= go_vehicle.                  " Downcast / Sicht wird erweitert


       ENDIF.

       go_truck2->a = 'a'.
       go_truck2->a = 'b'.
       go_truck2->a = 'c'.
       go_truck2->a = 'e'.
       go_truck2->get_cargo(  ).
       go_truck2->get_count(  ).
       go_truck2->get_make(  ).









  ENDMETHOD.
ENDCLASS.
