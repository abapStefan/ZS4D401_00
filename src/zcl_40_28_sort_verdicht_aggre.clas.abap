CLASS zcl_40_28_sort_verdicht_aggre DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_28_sort_verdicht_aggre IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

** Order by

*   SELECT FROM /dmo/connection
*         FIELDS  carrier_id,
*                connection_id,
*                airport_from_id,
*                distance
**                WHERE carrier_id = 'LH'
*         ORDER BY carrier_id
*              INTO TABLE @DATA(result_raw).
*
*     out->write( result_raw ).

********************************************************************************
*
*   SELECT FROM /dmo/flight
*         FIELDS carrier_id,
*                connection_id,
*                flight_date,
*                seats_max - seats_occupied  AS banane
**                WHERE carrier_id = 'LH'
*         ORDER BY seats_max - seats_occupied DESCENDING,
*                  flight_date ASCENDING
*              INTO TABLE @DATA(result_sitz).
*
*     out->write( result_sitz ).

** Distinct

*   SELECT FROM /dmo/connection
*         FIELDS DISTINCT carrier_id,
*                connection_id,
*                airport_from_id,
*                distance,
*                distance_unit
**                WHERE carrier_id = 'LH'
**         ORDER BY carrier_id
*              INTO TABLE @DATA(result_raw).
*
*     out->write( result_raw ).


** Nur Aggregatsfunktionen in der Feldliste

*SELECT FROM /dmo/connection
*         FIELDS
*                MAX( distance ) AS max_dist,
*                MIN( distance ) AS min_dist,
*                SUM( distance ) AS sum_dist,
*                AVG( distance AS fltp ) AS avg_dist,
*                count( * ) AS count,
*                count( DISTINCT airport_from_id ) AS acount_dist_airpfrom
*
*       WHERE carrier_id = 'UA'
*
*              INTO TABLE @DATA(result_aggregate).
*
*     out->write( result_aggregate ).


** Der Zusatz GROUP BY

SELECT FROM /dmo/connection
         FIELDS   carrier_id,
                MAX( distance ) AS max_dist,
                MIN( distance ) AS min_dist,
                SUM( distance ) AS sum_dist,
                AVG( distance AS dec( 10,2 ) ) AS avg_dist,

                count( * ) AS count,
                count( DISTINCT airport_from_id ) AS acount_dist_airpfrom

*       WHERE carrier_id = 'UA'
          GROUP BY carrier_id, connection_id
              INTO TABLE @DATA(result_aggregate).

     out->write( result_aggregate ).


  ENDMETHOD.
ENDCLASS.
