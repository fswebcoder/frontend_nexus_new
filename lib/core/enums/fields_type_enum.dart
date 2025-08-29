enum FieldTypeEnum{
  onlyNumberType("Numérico"),
  onlyLetterType("Caracteres"),
  allCharactersType("Alfanumérico"),
  uploadFyleType("Carga"),
  signatureType("Firma");

  final String label;
  const FieldTypeEnum(this.label);

}