CLASS zcl_40_22_zeichenketten_regex DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_40_22_zeichenketten_regex IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  DATA text TYPE string VALUE `  SAP BTP, ABAP  enviroment  `.
*  out->write( |Input String = { text }| ).

*
*** Beschreibungsfunktion (gibt einen ganzzahligen Wert zurück)
**********************************************************************************
*
*  DATA result_int TYPE i.
*
*  result_int = numofchar( text ).
*
*  out->write( |NUMOFCHAR                           =   { result_int }   | ).
*
*
*  result_int = find( val = text sub = 'env' ).
*
*  out->write( |FIND  'env'                         =   { result_int }   | ).
*
*** Bearbeitungsfunktion (gibt einen String Wert zurück)
**********************************************************************************
*
*DATA result_string TYPE string.
*
*result_string = replace(  val = text sub = 'env' with = 'ENV' ).
*
*out->write( |REPLACE  'env' with 'ENV'           =   { result_string }   | ).
*
*
*** Prädikatsfunktion (dient als logischer ausdruck)
**********************************************************************************
*
* IF contains( val = text sub = 'env' ).
*
* out->write( |CONTAINS  'env'   is true | ).
*
* ELSE.
*
* out->write( |CONTAINS  'env'   is false | ).
*
* ENDIF.
*
*" Verwende die Funktion XSDBOOL( ), um Prädikatsfunktion
*" in die Werte 'X' (für wahr)  und ' ' (für falsch)
*
* DATA result_char1 TYPE abap_bool.     " Type c LENGTH 1
* result_char1 = xsdbool(  contains( val = text sub = 'env' ) ).
*
* out->write( |XSDBOOL(CONTAINS 'env' )            =   { result_char1 }   | ).

***********************************************************************************

*DATA text TYPE string VALUE `  let´s talk about abap  `.
*DATA result TYPE i.
*
*out->write( |input string: { text } | ).
*
*out->Write( '---------------------------------------------------------------' ).
*
*result = find( val = text sub = 'a' case = abap_true ).
*out->write( |find 'a'  (standard):                             { result }| ).
*
*result = find( val = text sub = 'a' case = abap_false ).
*out->write( |find 'a'  (case = abap_false):                    { result }| ).
*
*result = find( val = text sub = 'a' case = abap_false occ = -1  ).
*out->write( |find 'a'  (occ = -1):                             { result }| ).
*
*result = find( val = text sub = 'a' case = abap_false occ = -2 ).
*out->write( |find 'a'  (occ = -2):                             { result }| ).
*
*result = find( val = text sub = 'a' case = abap_false occ = 2 ).
*out->write( |find 'a'  (occ = 2):                              { result }| ).
*
*result = find( val = text sub = 'a' case = abap_false occ = 2 OFF = 10 ).
*out->write( |find 'a'  (occ = 2 off = 10):                     { result }| ).
*
*result = find( val = text sub = 'a' case = abap_false occ = 2 OFF = 10 len = 4 ).
*out->write( |find 'a'  (occ = 2 off = 10 len = 4):             { result }| ).


*****************************************************************************************

*DATA result TYPE i.
*
*DATA text TYPE string VALUE `  ABAP  `.
**DATA text TYPE string VALUE '  ABAP  '.
*DATA substring Type string VALUE `BA`.
*DATA offset TYPE i VALUE 1.

*** Aufruf verschiedener Beschreibungsfunktionen
**********************************************************************************

*out->write( |input string: { text } | ).
*out->Write( '---------------------------------------------------------------' ).
*
*result = strlen( text ).
*out->write( |strlen:                             { result }| ).
*
*result = numofchar( text ).
*out->write( |Numofchar:                          { result }| ).
*
*result = count(   val =  text sub = substring  off = offset ).
*out->write( |count { substring }:                           { result }| ).
*
*result = find(   val =  text sub = substring  off = offset ).
*out->write( |find { substring }:                            { result }| ).
*
*result = count_any_of(   val =  text sub = substring  off = offset ).
*out->write( |count_any_of { substring }:                    { result }| ).
*
*result = find_any_of(   val =  text sub = substring  off = offset ).
*out->write( |find_any_of { substring }:                     { result }| ).
*
*result = count_any_not_of(   val =  text sub = substring off = offset  ).
*out->write( |count_any_not_of { substring }:                { result }| ).
*
*result = find_any_not_of(   val =  text sub = substring  off = offset  ).
*out->write( |find_any_not_of { substring }:                 { result }| ).

*************************************************************************************

*DATA text TYPE string         VALUE ` ASP BTP,    ABAP Enviroment`.
*
*out->write( |input string: { text } | ).
*out->Write( '---------------------------------------------------------------' ).
*
*
*** Groß / Kleinbuchstabenänderung
*************************************************************************************
*
*out->write( |TO_UPPER                            = '{ to_upper(  `##ABAP_is_cool` ) }'| ).
*out->write( |TO_LOWER                            = '{ to_lower(  text ) }'| ).
*out->write( |TO_MIXED                            = '{ to_mixed(  text ) }'| ).
*out->write( |TO_MIXED                            = '{ to_mixed(  'make_this_mixed' ) }'| ).
*out->write( |FROM_MIXED                          = '{ from_mixed(  text ) }'| ).
*
*
*
*** Reihenfolge der Zeichen ändern
*************************************************************************************
*
*out->write( |REVERSE                             = '{ reverse(  text ) }'| ).
*out->write( |SHIFT_LEFT (places)                 = '{ shift_left(  val = text  places = 3 ) }'| ).
*out->write( |SHIFT_RIGHT (places)                = '{ shift_right(  val = text  places = 3 ) }'| ).
*out->write( |SHIFT_LEFT (circ)                   = '{ shift_left(  val = text  circular = 3 ) }'| ).
*out->write( |SHIFT_RIGHT (circ)                  = '{ shift_right(  val = text  circular = 3 ) }'| ).
*
*
*** Substring extrahieren
*************************************************************************************
*
*out->write( |SUBSTRING                           = '{ substring( val = text off = 4 len = 10 ) }| ).
*out->write( |SUBSTRING_FROM                      = '{ substring_from( val = text sub = 'ABAP' ) }| ).
*out->write( |SUBSTRING_AFTER                     = '{ substring_after( val = text sub = `ABAP ` ) }| ).
*out->write( |SUBSTRING_TO                        = '{ substring_to( val = text sub = 'ABAP' ) }| ).
*out->write( |SUBSTRING_BEFORE                    = '{ substring_before( val = text sub = 'ABAP' ) }| ).
*
*
*** Condense Reapeat und Segment
*************************************************************************************
*
*out->write( |CONDENSE                            = '{ condense( val = text from = ` ` TO = ``  ) }' | ).
*out->write( |CONDENSE                            = '{ condense( val = text ) }' | ).
*out->write( |REPEAT                              = '{ repeat( val = text occ = 3 ) }' | ).
*out->write( |SEGMENT1                            = '{ segment( val = text sep = ',' index = 1 ) }' | ).
*out->write( |SEGMENT2                            = '{ segment( val = text sep = ',' index = 2 ) }' | ).


*
*DATA text TYPE string         VALUE ` ASP BTP,    ABAP Enviroment`.
*
*out->write( |input string: { text } | ).
*out->Write( '---------------------------------------------------------------' ).
*
*** Prüfen ob eine Zeichenkette eine bestimmte Teilzeichenkette enhält
***************************************************************************************
*
*out->write( |CONTAINS 'ABAP':                                   { xsdbool( contains(  val = text sub = 'ABAP' ) ) } | ).
*out->write( |CONTAINS 'ABAP', off = 20:                         { xsdbool( contains(  val = text sub = 'ABAP' off = 20 ) ) } | ).
*out->write( |CONTAINS 'ABAP', start = 'ABAP', off = 12:         { xsdbool( contains(  val = text start = 'ABAP' off = 13 ) ) } | ).
*
*
*** Prüfen ob eine Zeichenfolge Zeichen aus einer Liste von Zeichen enthält
***************************************************************************************
*
*out->write( |CONTAINS_ANY_OF 'ABC':                     { xsdbool( contains_any_of(  val = text sub = 'ABC' ) ) } | ).
*out->write( |CONTAINS_ANY_OF 'XYZ':                     { xsdbool( contains_any_of(  val = text sub = 'XYZ' ) ) } | ).
*
*
*** Prüfen ob eine Zeichenkette Zeichen ausserhalb einer Liste von Zeichen enthält
***************************************************************************************
*
*out->write( |CONTAINS_ANY_NOT_OF 'ABC':                     { xsdbool( contains_any_not_of(  val = text sub = 'ABC' ) ) } | ).
*out->write( |CONTAINS_ANY_NOT_OF 'XYZ':                     { xsdbool( contains_any_not_of(  val = text sub = 'XYZ' ) ) } | ).





*** Reguläre Ausdrücke
****************************************************************************************
*
**    DATA text TYPE string      VALUE `2026-11-09`.
*    DATA text TYPE string      VALUE `Sehr geehrte Damen und Herren zu Auswahl, haben wir den 2026-03-26 ist ein Datum im ISO-Format oder den 2026-04-04 `.    "Schritt 1
**    DATA text TYPE string      VALUE `1989-11-09`.
**
**   DATA text TYPE string      VALUE `Zum Beispiel, 23.03.2026 ist nicht im ISO-Format`.
**    DATA text TYPE string      VALUE `2026.03.23`.
**   DATA text TYPE string      VALUE `Zum Beispiel, 2026.03.23 ist nicht im ISO-Format`.
*
*     DATA regex TYPE string VALUE '[0-9]{4}(-[0-9]{2}){2}'.
**     DATA regex TYPE string VALUE '[0-9]{4}(\.[0-9]{2}){2}'.
**
*    out->write( |Zu verarbeitender Text    = `{ text  }` | ).
*    out->write( |Regular Expression        = `{ regex }` | ).
*    out->write(  `--------------------------------------------------` ).
*
*    IF NOT contains(  val = text pcre = regex ).
*        out->write( `Kein passenden Suchstring gefunden` ).
*    ELSE.
*
*       DATA(number) = count(  val = text pcre  = regex ).
*        out->write( |Anzahl der Befunde   = { number } | ).
*
*       DATA(offset) = find(  val = text pcre = regex occ = 1 ).
*        out->write( |Offset des ersten Befundes = { offset }| ).
*
*       DATA(date_text) = match( val = text pcre = regex occ = 1 ).
*        out->write(  |2st Befund extrahiert = `{ date_text }` | ).
*
*        IF matches( val = text pcre = regex ).
*        out->write( `Dann ist das ein complete match` ).
*        ELSE.
*        out->write( `kein complete match` ).
*      ENDIF.
*     ENDIF.


DATA result TYPE i.

result = find_any_of( val = 'ABAP ABAP abap' sub = 'AB' ).
out->write( |find_any_of:       { result }| ).

result = count_any_of( val = 'ABAP ABAP abap' sub = 'AB' ).
out->write( |count_any_of:      { result }| ).

result = count( val = 'ABAP ABAP abap' sub = 'AB' ).
out->write( |count:             { result }| ).

result = find_any_not_of( val = 'ABAP ABAP abap' sub = 'AB' ).
out->write( |find_any_not_of:   { result }| ).



  ENDMETHOD.
ENDCLASS.
