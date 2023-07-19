
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZDD_LIBRARY04AS'
@ObjectModel.semanticKey: [ 'IssueID' ]
define root view entity ZC_LIBRARY04AS
  provider contract transactional_query
  as projection on ZDD_LIBRARY04AS
{
  key IssueID,
      @Consumption.valueHelpDefinition: [{entity :{ name: 'ZDD_STUDENT04AS' ,element: 'StudID'} }]
      StudID,
       @Consumption.valueHelpDefinition: [{entity :{ name: 'ZDD_BOOK04AS' ,element: 'BookID'} }]
      BookID,
      IsDate,
      RetDate,
      IsReturn,
      Fine,
    //  @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element: 'currencycode'} }]
      currencycode,
      LocalLastChangedAt,

      /* Associations */
      _Student,

      _Student.StudName,
      _Student.StudPhone,
      _Student.StudEmail,
      _Student.StudAge,
      _Student.StudGender,
      _Student.BLimit,

      _BOOK,
      _BOOK.BookName,
      _BOOK.BookPrice,
      _BOOK.CurrencyCode as BookCurrencyCode,
      _BOOK.BookAuthor,
      _BOOK.Department,
      _BOOK.BookCount,
      _BOOK.AvailCount

}
