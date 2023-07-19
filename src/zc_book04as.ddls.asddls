@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZDD_BOOK04AS'
@ObjectModel.semanticKey: [ 'BookID' ]
define root view entity ZC_BOOK04AS
  provider contract transactional_query
  as projection on ZDD_BOOK04AS
{
  key BookID,
  
   @Consumption.valueHelpDefinition: [{entity :{ name: 'ZDD_BOOK04AS' ,element: 'BookName'} }]
  BookName,
  
  BookPrice,
  //@Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'CurrencyCode' }}]
  CurrencyCode,
    @Consumption.valueHelpDefinition: [{entity :{ name: 'ZDD_BOOK04AS' ,element: 'BookAuthor'} }]
  BookAuthor,
  @Consumption.valueHelpDefinition: [{entity :{ name: 'ZDD_BOOK04AS' ,element: 'Department'} }]
  Department,
  BookCount,
  AvailCount,
 // TotalValue,
  LocalLastChangedAt
  //division(cast(BookPrice as abap.dec(10,2)), division(1, cast(BookCount as abap.int8), 2), 2) as TotalValue
  
}
