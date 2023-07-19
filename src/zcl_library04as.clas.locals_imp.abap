CLASS lhc_library DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Library
        RESULT result.

    METHODS issueBook FOR DETERMINE ON SAVE
      IMPORTING keys FOR Library~issueBook.

    METHODS validateBookId FOR VALIDATE ON SAVE
      IMPORTING keys FOR Library~validateBookId.

    METHODS validateStudentId FOR VALIDATE ON SAVE
      IMPORTING keys FOR Library~validateStudentId.

    METHODS returnBook FOR MODIFY
      IMPORTING keys FOR ACTION Library~returnBook RESULT res.

    METHODS valReturnDate FOR VALIDATE ON SAVE
      IMPORTING keys FOR Library~valReturnDate.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Library RESULT result.



ENDCLASS.

CLASS lhc_library IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  METHOD issueBook.

    TYPES: BEGIN OF get_amount_for_currecy_code,
             amount        TYPE zdd_library04as-Fine,
 currency_code TYPE zdd_library04as-currencycode,
           END OF get_amount_for_currecy_code.

    DATA: amount_ TYPE STANDARD TABLE OF get_amount_for_currecy_code.



    READ ENTITIES OF zdd_library04as IN LOCAL MODE
    ENTITY Library
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(iss).


    DATA is_returned TYPE i.


    LOOP AT iss ASSIGNING FIELD-SYMBOL(<is>).
      "Getting available count.

      READ ENTITIES OF zdd_book04as
      ENTITY Book
      ALL FIELDS WITH VALUE #( ( BookID = <is>-BookID ) )
      RESULT DATA(books).

      LOOP AT books ASSIGNING FIELD-SYMBOL(<book>).
        <book>-AvailCount -= 1.
      ENDLOOP.

      MODIFY ENTITIES OF zdd_book04as
      ENTITY Book UPDATE FIELDS ( AvailCount ) WITH CORRESPONDING #( books ).

    ENDLOOP.

  ENDMETHOD.

  METHOD returnBook.
    READ ENTITIES OF zdd_library04as IN LOCAL MODE
    ENTITY Library
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(iss).

    LOOP AT iss ASSIGNING FIELD-SYMBOL(<is>).
      "Getting available count.

      READ ENTITIES OF zdd_book04as
      ENTITY Book
      ALL FIELDS WITH VALUE #( ( BookID = <is>-BookID ) )
      RESULT DATA(books).

      LOOP AT books ASSIGNING FIELD-SYMBOL(<book>).
        DATA diff_days TYPE i.

        <book>-AvailCount += 1.

        " Add fine if required
        diff_days = sy-datum - <is>-RetDate.

        IF diff_days > 0.

          DATA fineperday TYPE f VALUE 10.

          <is>-Fine = ( diff_days * fineperday ).

        ENDIF.
      ENDLOOP.
      MODIFY ENTITIES OF zdd_book04as
     ENTITY Book UPDATE FIELDS ( AvailCount ) WITH CORRESPONDING #( books ).
    ENDLOOP.

    MODIFY ENTITIES OF zdd_library04as IN LOCAL MODE
    ENTITY Library UPDATE FIELDS ( Fine ) WITH CORRESPONDING #( iss ).

    READ ENTITIES OF zdd_library04as IN LOCAL MODE
  ENTITY Library
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(iss_updated).

    res = VALUE #( FOR is IN iss_updated ( %tky = is-%tky %param = is ) ).

  ENDMETHOD.

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 METHOD validateBookId.
    "Reading data from cds
    READ ENTITIES OF zdd_library04as IN LOCAL MODE
    ENTITY Library FIELDS ( BookID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_BookIDKey).

    LOOP AT lt_BookIDKey INTO DATA(ls_BookID).
      "Fetching BookID
      SELECT FROM zdd_book04as FIELDS BookID
       WHERE BookID = @ls_BookID-BookID
       INTO TABLE @DATA(lt_bid).
      "validating BookID and throwing error
      IF lt_bid IS INITIAL.
        DATA(lvr_message) = me->new_message(
                          id       = 'ZBI_MSG'
                          number   = 004
                          severity = ms-error
                          v1       = ls_BookID-BookID
                        ).
        "displays error msg
        DATA ls_record06 LIKE LINE OF reported-Library.
        ls_record06-%msg = lvr_message.
        APPEND ls_record06 TO reported-Library.
        "Highlights the column
        DATA ls_failed06 LIKE LINE OF failed-Library.
        APPEND ls_failed06 TO failed-Library.
      ENDIF.
    ENDLOOP.
*
 ENDMETHOD.
*
*  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
  METHOD validateStudentId.
*    "Reading data from cds
    READ ENTITIES OF zdd_library04as IN LOCAL MODE
    ENTITY Library FIELDS ( StudID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_StudIDkey).

    LOOP AT lt_StudIDkey INTO DATA(ls_StudID).
      "Fetching STUDENTID
      SELECT FROM zdd_student04as FIELDS StudID
       WHERE StudID = @ls_StudID-StudID
       INTO TABLE @DATA(lt_stid).
      "validating STUDENTID and throwing error
      IF lt_stid IS INITIAL.
        DATA(message) = me->new_message(
                          id       = 'ZST_MSG'
                          number   = 003
                          severity = ms-error
                          v1       = ls_StudID-StudID
                        ).
        "displays error msg
        DATA ls_record04 LIKE LINE OF reported-Library.
        ls_record04-%msg = message.
        APPEND ls_record04 TO reported-Library.
        "Highlights the column
        DATA ls_failed04 LIKE LINE OF failed-Library.
        APPEND ls_failed04 TO failed-Library.
      ENDIF.
    ENDLOOP.
*
 ENDMETHOD.
*
*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 METHOD valReturnDate.

    READ ENTITIES OF zdd_library04as IN LOCAL MODE
      ENTITY Library ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(libs).

    LOOP AT libs INTO DATA(lib).
      IF lib-IsDate > lib-RetDate.

        DATA(lvr_message) = me->new_message(
                          id       = 'ZCUR_MSG'
                          number   = 005
                          severity = ms-error
                        ).
        "displays error msg
        DATA ls_record06 LIKE LINE OF reported-Library.
        ls_record06-%msg = lvr_message.
        APPEND ls_record06 TO reported-Library.
        "Highlights the column
        DATA ls_failed06 LIKE LINE OF failed-Library.
        APPEND ls_failed06 TO failed-Library.
      ENDIF.
    ENDLOOP.


 ENDMETHOD.
*
 METHOD get_instance_features.
 ENDMETHOD.

ENDCLASS.
