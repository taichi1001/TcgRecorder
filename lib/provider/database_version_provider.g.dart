// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_version_provider.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetDatabaseVersionCollection on Isar {
  IsarCollection<int, DatabaseVersion> get databaseVersions =>
      this.collection();
}

const DatabaseVersionSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'DatabaseVersion',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'version',
        type: IsarType.long,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, DatabaseVersion>(
    serialize: serializeDatabaseVersion,
    deserialize: deserializeDatabaseVersion,
    deserializeProperty: deserializeDatabaseVersionProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeDatabaseVersion(IsarWriter writer, DatabaseVersion object) {
  IsarCore.writeLong(writer, 1, object.version);
  return object.id;
}

@isarProtected
DatabaseVersion deserializeDatabaseVersion(IsarReader reader) {
  final object = DatabaseVersion();
  object.id = IsarCore.readId(reader);
  object.version = IsarCore.readLong(reader, 1);
  return object;
}

@isarProtected
dynamic deserializeDatabaseVersionProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readLong(reader, 1);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _DatabaseVersionUpdate {
  bool call({
    required int id,
    int? version,
  });
}

class _DatabaseVersionUpdateImpl implements _DatabaseVersionUpdate {
  const _DatabaseVersionUpdateImpl(this.collection);

  final IsarCollection<int, DatabaseVersion> collection;

  @override
  bool call({
    required int id,
    Object? version = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (version != ignore) 1: version as int?,
        }) >
        0;
  }
}

sealed class _DatabaseVersionUpdateAll {
  int call({
    required List<int> id,
    int? version,
  });
}

class _DatabaseVersionUpdateAllImpl implements _DatabaseVersionUpdateAll {
  const _DatabaseVersionUpdateAllImpl(this.collection);

  final IsarCollection<int, DatabaseVersion> collection;

  @override
  int call({
    required List<int> id,
    Object? version = ignore,
  }) {
    return collection.updateProperties(id, {
      if (version != ignore) 1: version as int?,
    });
  }
}

extension DatabaseVersionUpdate on IsarCollection<int, DatabaseVersion> {
  _DatabaseVersionUpdate get update => _DatabaseVersionUpdateImpl(this);

  _DatabaseVersionUpdateAll get updateAll =>
      _DatabaseVersionUpdateAllImpl(this);
}

sealed class _DatabaseVersionQueryUpdate {
  int call({
    int? version,
  });
}

class _DatabaseVersionQueryUpdateImpl implements _DatabaseVersionQueryUpdate {
  const _DatabaseVersionQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<DatabaseVersion> query;
  final int? limit;

  @override
  int call({
    Object? version = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (version != ignore) 1: version as int?,
    });
  }
}

extension DatabaseVersionQueryUpdate on IsarQuery<DatabaseVersion> {
  _DatabaseVersionQueryUpdate get updateFirst =>
      _DatabaseVersionQueryUpdateImpl(this, limit: 1);

  _DatabaseVersionQueryUpdate get updateAll =>
      _DatabaseVersionQueryUpdateImpl(this);
}

class _DatabaseVersionQueryBuilderUpdateImpl
    implements _DatabaseVersionQueryUpdate {
  const _DatabaseVersionQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<DatabaseVersion, DatabaseVersion, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? version = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (version != ignore) 1: version as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension DatabaseVersionQueryBuilderUpdate
    on QueryBuilder<DatabaseVersion, DatabaseVersion, QOperations> {
  _DatabaseVersionQueryUpdate get updateFirst =>
      _DatabaseVersionQueryBuilderUpdateImpl(this, limit: 1);

  _DatabaseVersionQueryUpdate get updateAll =>
      _DatabaseVersionQueryBuilderUpdateImpl(this);
}

extension DatabaseVersionQueryFilter
    on QueryBuilder<DatabaseVersion, DatabaseVersion, QFilterCondition> {
  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      versionEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      versionGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      versionGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      versionLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      versionLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterFilterCondition>
      versionBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension DatabaseVersionQueryObject
    on QueryBuilder<DatabaseVersion, DatabaseVersion, QFilterCondition> {}

extension DatabaseVersionQuerySortBy
    on QueryBuilder<DatabaseVersion, DatabaseVersion, QSortBy> {
  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterSortBy>
      sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }
}

extension DatabaseVersionQuerySortThenBy
    on QueryBuilder<DatabaseVersion, DatabaseVersion, QSortThenBy> {
  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterSortBy>
      thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }
}

extension DatabaseVersionQueryWhereDistinct
    on QueryBuilder<DatabaseVersion, DatabaseVersion, QDistinct> {
  QueryBuilder<DatabaseVersion, DatabaseVersion, QAfterDistinct>
      distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1);
    });
  }
}

extension DatabaseVersionQueryProperty1
    on QueryBuilder<DatabaseVersion, DatabaseVersion, QProperty> {
  QueryBuilder<DatabaseVersion, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<DatabaseVersion, int, QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }
}

extension DatabaseVersionQueryProperty2<R>
    on QueryBuilder<DatabaseVersion, R, QAfterProperty> {
  QueryBuilder<DatabaseVersion, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<DatabaseVersion, (R, int), QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }
}

extension DatabaseVersionQueryProperty3<R1, R2>
    on QueryBuilder<DatabaseVersion, (R1, R2), QAfterProperty> {
  QueryBuilder<DatabaseVersion, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<DatabaseVersion, (R1, R2, int), QOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseVersionNotifierHash() =>
    r'53f6893ab890342fb09c9d57d47fb8a1ee0818b5';

/// See also [DatabaseVersionNotifier].
@ProviderFor(DatabaseVersionNotifier)
final databaseVersionNotifierProvider =
    NotifierProvider<DatabaseVersionNotifier, DatabaseVersion>.internal(
  DatabaseVersionNotifier.new,
  name: r'databaseVersionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseVersionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DatabaseVersionNotifier = Notifier<DatabaseVersion>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
