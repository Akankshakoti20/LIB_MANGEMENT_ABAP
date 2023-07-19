CLASS zc_msg DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .
    INTERFACES if_abap_behv_message.

    CONSTANTS:
        BEGIN OF no_books,
        msgid TYPE symsgid VALUE 'Z_MSG04AS',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'BOOKID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
        END OF no_books.

    CONSTANTS:
        BEGIN OF limit_exceeded,
        msgid TYPE symsgid VALUE 'Z_MSG04AS',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
        END OF limit_exceeded.

   CONSTANTS:
        BEGIN OF book_unknown,
        msgid TYPE symsgid VALUE 'Z_MSG04AS',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'BOOKID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
        END OF book_unknown.

   CONSTANTS:
        BEGIN OF student_fine,
        msgid TYPE symsgid VALUE 'Z_MSG04AS',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'FINE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
        END OF student_fine.

   CONSTANTS:
        BEGIN OF student_unknown,
        msgid TYPE symsgid VALUE 'Z_MSG04AS',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'STUDENTID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
        END OF student_unknown.

   CONSTANTS:
        BEGIN OF msg_error,
        msgid TYPE symsgid VALUE 'Z_MSG04AS',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE 'ERROR',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
        END OF msg_error.


    METHODS constructor
      IMPORTING
        severity TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        textid   LIKE if_t100_message=>t100key OPTIONAL
        previous LIKE previous OPTIONAL .

    DATA bookid TYPE string READ-ONLY.
    DATA studentid TYPE string READ-ONLY.
    DATA fine TYPE string READ-ONLY.
    DATA error TYPE string READ-ONLY.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zc_msg IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.


    me->if_abap_behv_message~m_severity = severity.
    me->bookid = |{ bookid ALPHA = OUT }|.
    me->studentid = |{ studentid ALPHA = OUT }|.
    me->fine = |{ fine ALPHA = OUT }|.
    me->error = |{ error ALPHA = OUT }|.


  ENDMETHOD.
ENDCLASS.
