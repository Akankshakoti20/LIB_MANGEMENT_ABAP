@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED LIB'
define root view entity ZI_LIB04
  as select from zlibrary04 as ZILIB04
{
  key issue_id as IssueID,
  stud_id as StudID,
  book_id as BookID,
  is_date as IsDate,
  ret_date as RetDate,
  is_return as IsReturn,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  fine as Fine,
  currency_code as CurrencyCode,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
  
}
