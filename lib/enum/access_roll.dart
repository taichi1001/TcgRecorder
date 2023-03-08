enum AccessRoll {
  owner('ゲーム'),
  writer('デッキ'),
  reader('タグ'),
  ;

  const AccessRoll(this.displayName);
  final String displayName;
}
