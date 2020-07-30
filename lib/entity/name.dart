class Name {
  int nameId;
  String name;

  Name({
    this.nameId,
    this.name,
  });

  factory Name.fromDatabaseJson(Map<String, dynamic> data) => Name(
        nameId: data['name_id'],
        name: data['name'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'name_id': nameId,
        'name': name,
      };
}
