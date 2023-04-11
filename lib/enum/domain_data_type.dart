enum DomainDataType {
  game('ゲーム'),
  deck('デッキ'),
  tag('タグ'),
  ;

  const DomainDataType(this.displayName);
  final String displayName;
}
