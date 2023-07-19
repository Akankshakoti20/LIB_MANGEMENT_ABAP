@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '##GENERATED StudentDetails'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }
define root view entity ZDD_STUDENT04AS
  as select from zstudent04 as Student

  association [1..*] to ZDD_LIBRARY04AS as _Library on $projection.StudID = _Library.StudID

{
  key stud_id               as StudID,
      stud_name             as StudName,
      stud_phone            as StudPhone,
      stud_email            as StudEmail,
      stud_age              as StudAge,
      stud_gender           as StudGender,
      b_limit               as BLimit,
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
      
      _Library

}
