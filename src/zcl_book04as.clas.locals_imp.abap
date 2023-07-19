CLASS lhc_book DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Book
        RESULT result,
      valcurrencycode FOR VALIDATE ON SAVE
        IMPORTING keys FOR Book~valcurrencycode,
      decrementBookCount FOR MODIFY
        IMPORTING keys FOR ACTION Book~decrementBookCount.

    METHODS incrementBookCount FOR MODIFY
      IMPORTING keys FOR ACTION Book~incrementBookCount.
ENDCLASS.

CLASS lhc_book IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  METHOD valcurrencycode.
    "Reading data from cds
*    READ ENTITIES OF zdd_book04as IN LOCAL MODE
*    ENTITY Book FIELDS ( BookId  )
*    WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_currencykey).
*
*    LOOP AT lt_currencykey INTO DATA(ls_curr).
*      "Fetching Currency
*      SELECT FROM I_Currency  FIELDS Currency
*      WHERE Currency = @ls_curr-CurrencyCode
*      INTO TABLE @DATA(lt_curr).
*      "validating currency and throwing error
*      IF lt_curr IS INITIAL.
*
*        DATA(lv_message) = me->new_message(
*                          id       =  'ZCUR_MSG'
*                          number   =  001
*                          severity = ms-error
*                           v1       = ls_curr-CurrencyCode
*                        ).
*        "displays error msg
*        DATA ls_record LIKE LINE OF reported-book.
*        ls_record-%msg = lv_message.
*        ls_record-%element-currencycode = if_abap_behv=>mk-on.
*        APPEND ls_record TO reported-book.
*
*        DATA ls_fail LIKE LINE OF failed-book.
*        APPEND ls_fail TO failed-book.
*      ENDIF.
*
*    ENDLOOP.

  ENDMETHOD.

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  METHOD decrementBookCount.
    READ ENTITIES OF zdd_book04as IN LOCAL MODE
    ENTITY Book
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(books).

    MODIFY ENTITIES OF zdd_book04as IN LOCAL MODE
    ENTITY Book
    UPDATE FIELDS ( AvailCount ) WITH VALUE #( FOR book IN books ( BookId = book-BookId
    AvailCount = book-AvailCount - 1 ) )
    FAILED DATA(failure).

  ENDMETHOD.

  METHOD incrementBookCount.
    READ ENTITIES OF zdd_book04as IN LOCAL MODE
    ENTITY Book
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(books).

    MODIFY ENTITIES OF zdd_book04as IN LOCAL MODE
    ENTITY Book
    UPDATE FIELDS ( AvailCount ) WITH VALUE #( FOR book IN books ( BookId = book-BookId
    AvailCount = book-AvailCount + 1 ) )
    FAILED DATA(failure).
  ENDMETHOD.

ENDCLASS.
