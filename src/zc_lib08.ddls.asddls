@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZI_LIB04'
@ObjectModel.semanticKey: [ 'IssueID' ]
define root view entity ZC_LIB08
  provider contract transactional_query
  as projection on ZI_LIB04
{
  key IssueID,
  StudID,
  BookID,
  IsDate,
  RetDate,
  IsReturn,
  Fine,
  CurrencyCode,
  LocalLastChangedAt
  
}
