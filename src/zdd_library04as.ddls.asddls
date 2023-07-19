
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED Library Details'
define root view entity ZDD_LIBRARY04AS
  as select from zlibrary04 as Library

  association [1..1] to ZDD_BOOK04AS    as _BOOK    on $projection.BookID = _BOOK.BookID

  association [1..1] to ZDD_STUDENT04AS as _Student on $projection.StudID = _Student.StudID

{
  key issue_id              as IssueID,
      stud_id               as StudID,
      book_id               as BookID,
      is_date               as IsDate,
      ret_date              as RetDate,
      is_return             as IsReturn,
      fine                  as Fine,
      currency_code         as currencycode,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,


      //DATEDIFF(fine,  is_date ,  ret_date ) as DaysIssued,

      _BOOK,
      _Student


}
