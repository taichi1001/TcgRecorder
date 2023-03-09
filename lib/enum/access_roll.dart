enum AccessRoll {
  owner('owner'),
  writer('writer'),
  reader('reader'),
  ;

  const AccessRoll(this.displayName);
  final String displayName;
}
