@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZDD_STUDENT04AS'
@ObjectModel.semanticKey: [ 'StudID' ]
define root view entity ZC_STUDENT04AS
  provider contract transactional_query
  as projection on ZDD_STUDENT04AS
{
  key StudID,
    @Consumption.valueHelpDefinition: [{entity :{ name: 'ZDD_STUDENT04AS' ,element: 'StudName'} }]
  StudName,
   @Consumption.valueHelpDefinition: [{entity :{ name: 'ZDD_STUDENT04AS' ,element: 'StudPhone'} }]
  StudPhone,
   @Consumption.valueHelpDefinition: [{entity :{ name: 'ZDD_STUDENT04AS' ,element: 'StudEmail'} }]
  StudEmail,
   @Consumption.valueHelpDefinition: [{entity :{ name: 'ZDD_STUDENT04AS' ,element: 'StudAge'} }]
  StudAge,
   @Consumption.valueHelpDefinition: [{entity :{ name: 'ZDD_STUDENT04AS' ,element: 'StudGender'} }]
  StudGender,
  BLimit,
  LocalLastChangedAt
  
}
