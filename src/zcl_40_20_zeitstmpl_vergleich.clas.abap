CLASS zcl_40_20_zeitstmpl_vergleich DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_20_zeitstmpl_vergleich IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Abbildung 55.

*    DATA utc_long1 TYPE utclong.
*    DATA utc_long2 TYPE utclong.
*    DATA diff TYPE decfloat34.
*
*    utc_long1 = utclong_current(  ).
*    utc_long2 = utclong_current(  ).
*
*    utc_long2 = utclong_add( val = utc_long2   days = 0  hours = 1  ).
*
*    diff = utclong_diff(  high =  utc_long2   low = utc_long1  ).
*
*
*    out->write( diff ).


* Abbildung 56


    DATA(utc_current) = utclong_current(  ).


    DATA(lv_zone_demo) = cl_abap_context_info=>get_user_time_zone( ).
    lv_zone_demo = 'UTC+1'.


    TRY.

        CONVERT UTCLONG  utc_current TIME ZONE  lv_zone_demo
                                  INTO DATE DATA(lv_date_demo)
                                       TIME DATA(lv_time_demo) .

        out->write( lv_date_demo ).
        out->write( lv_time_demo ).


      CATCH cx_root.

    ENDTRY.


  ENDMETHOD.
ENDCLASS.
