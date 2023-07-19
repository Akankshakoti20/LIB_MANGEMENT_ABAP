
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '##GENERATED Book Details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZDD_BOOK04AS
  as select from zbook04 as Book
  association to ZDD_LIBRARY04AS as _library on $projection.BookID = _library.BookID

{
  key book_id                                                                                        as BookID,
      //      stud_id               as StudID,
      book_name                                                                                      as BookName,
      //      issue_id              as IssueId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      book_price                                                                                     as BookPrice,
      currency_code                                                                                  as CurrencyCode,
      book_author                                                                                    as BookAuthor,
      department                                                                                     as Department,
      book_count                                                                                     as BookCount,
      avail_count                                                                                    as AvailCount,
  //    division(cast(book_price as abap.dec(10,2)), division(1, cast(book_count as abap.int8), 2), 2) as TotalValue,
      @Semantics.user.createdBy: true
      local_created_by                                                                               as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at                                                                               as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by                                                                          as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at                                                                          as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                                                                                as LastChangedAt,
      _library

}
