// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity_provider.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetUserActivityLogCollection on Isar {
  IsarCollection<int, UserActivityLog> get userActivityLogs =>
      this.collection();
}

const UserActivityLogSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'UserActivityLog',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'totalRecordCount',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'installDate',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'lastLogin',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'totalLoginDays',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'canRecord',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'isPublicDataUploaded',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'reviewdAt',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'dissatisfactionChosenAt',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'answerLaterChosenAt',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'showPremiumFeaturesAdAt',
        type: IsarType.dateTime,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, UserActivityLog>(
    serialize: serializeUserActivityLog,
    deserialize: deserializeUserActivityLog,
    deserializeProperty: deserializeUserActivityLogProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeUserActivityLog(IsarWriter writer, UserActivityLog object) {
  IsarCore.writeLong(writer, 1, object.totalRecordCount);
  IsarCore.writeLong(
      writer, 2, object.installDate.toUtc().microsecondsSinceEpoch);
  IsarCore.writeLong(
      writer, 3, object.lastLogin.toUtc().microsecondsSinceEpoch);
  IsarCore.writeLong(writer, 4, object.totalLoginDays);
  IsarCore.writeBool(writer, 5, object.canRecord);
  IsarCore.writeBool(writer, 6, object.isPublicDataUploaded);
  IsarCore.writeLong(writer, 7,
      object.reviewdAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808);
  IsarCore.writeLong(
      writer,
      8,
      object.dissatisfactionChosenAt?.toUtc().microsecondsSinceEpoch ??
          -9223372036854775808);
  IsarCore.writeLong(
      writer,
      9,
      object.answerLaterChosenAt?.toUtc().microsecondsSinceEpoch ??
          -9223372036854775808);
  IsarCore.writeLong(
      writer,
      10,
      object.showPremiumFeaturesAdAt?.toUtc().microsecondsSinceEpoch ??
          -9223372036854775808);
  return object.id;
}

@isarProtected
UserActivityLog deserializeUserActivityLog(IsarReader reader) {
  final object = UserActivityLog();
  object.id = IsarCore.readId(reader);
  object.totalRecordCount = IsarCore.readLong(reader, 1);
  {
    final value = IsarCore.readLong(reader, 2);
    if (value == -9223372036854775808) {
      object.installDate =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      object.installDate =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      object.lastLogin =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      object.lastLogin =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  object.totalLoginDays = IsarCore.readLong(reader, 4);
  object.canRecord = IsarCore.readBool(reader, 5);
  object.isPublicDataUploaded = IsarCore.readBool(reader, 6);
  {
    final value = IsarCore.readLong(reader, 7);
    if (value == -9223372036854775808) {
      object.reviewdAt = null;
    } else {
      object.reviewdAt =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      object.dissatisfactionChosenAt = null;
    } else {
      object.dissatisfactionChosenAt =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  {
    final value = IsarCore.readLong(reader, 9);
    if (value == -9223372036854775808) {
      object.answerLaterChosenAt = null;
    } else {
      object.answerLaterChosenAt =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  {
    final value = IsarCore.readLong(reader, 10);
    if (value == -9223372036854775808) {
      object.showPremiumFeaturesAdAt = null;
    } else {
      object.showPremiumFeaturesAdAt =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  return object;
}

@isarProtected
dynamic deserializeUserActivityLogProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readLong(reader, 1);
    case 2:
      {
        final value = IsarCore.readLong(reader, 2);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 3:
      {
        final value = IsarCore.readLong(reader, 3);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 4:
      return IsarCore.readLong(reader, 4);
    case 5:
      return IsarCore.readBool(reader, 5);
    case 6:
      return IsarCore.readBool(reader, 6);
    case 7:
      {
        final value = IsarCore.readLong(reader, 7);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 8:
      {
        final value = IsarCore.readLong(reader, 8);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 9:
      {
        final value = IsarCore.readLong(reader, 9);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 10:
      {
        final value = IsarCore.readLong(reader, 10);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _UserActivityLogUpdate {
  bool call({
    required int id,
    int? totalRecordCount,
    DateTime? installDate,
    DateTime? lastLogin,
    int? totalLoginDays,
    bool? canRecord,
    bool? isPublicDataUploaded,
    DateTime? reviewdAt,
    DateTime? dissatisfactionChosenAt,
    DateTime? answerLaterChosenAt,
    DateTime? showPremiumFeaturesAdAt,
  });
}

class _UserActivityLogUpdateImpl implements _UserActivityLogUpdate {
  const _UserActivityLogUpdateImpl(this.collection);

  final IsarCollection<int, UserActivityLog> collection;

  @override
  bool call({
    required int id,
    Object? totalRecordCount = ignore,
    Object? installDate = ignore,
    Object? lastLogin = ignore,
    Object? totalLoginDays = ignore,
    Object? canRecord = ignore,
    Object? isPublicDataUploaded = ignore,
    Object? reviewdAt = ignore,
    Object? dissatisfactionChosenAt = ignore,
    Object? answerLaterChosenAt = ignore,
    Object? showPremiumFeaturesAdAt = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (totalRecordCount != ignore) 1: totalRecordCount as int?,
          if (installDate != ignore) 2: installDate as DateTime?,
          if (lastLogin != ignore) 3: lastLogin as DateTime?,
          if (totalLoginDays != ignore) 4: totalLoginDays as int?,
          if (canRecord != ignore) 5: canRecord as bool?,
          if (isPublicDataUploaded != ignore) 6: isPublicDataUploaded as bool?,
          if (reviewdAt != ignore) 7: reviewdAt as DateTime?,
          if (dissatisfactionChosenAt != ignore)
            8: dissatisfactionChosenAt as DateTime?,
          if (answerLaterChosenAt != ignore)
            9: answerLaterChosenAt as DateTime?,
          if (showPremiumFeaturesAdAt != ignore)
            10: showPremiumFeaturesAdAt as DateTime?,
        }) >
        0;
  }
}

sealed class _UserActivityLogUpdateAll {
  int call({
    required List<int> id,
    int? totalRecordCount,
    DateTime? installDate,
    DateTime? lastLogin,
    int? totalLoginDays,
    bool? canRecord,
    bool? isPublicDataUploaded,
    DateTime? reviewdAt,
    DateTime? dissatisfactionChosenAt,
    DateTime? answerLaterChosenAt,
    DateTime? showPremiumFeaturesAdAt,
  });
}

class _UserActivityLogUpdateAllImpl implements _UserActivityLogUpdateAll {
  const _UserActivityLogUpdateAllImpl(this.collection);

  final IsarCollection<int, UserActivityLog> collection;

  @override
  int call({
    required List<int> id,
    Object? totalRecordCount = ignore,
    Object? installDate = ignore,
    Object? lastLogin = ignore,
    Object? totalLoginDays = ignore,
    Object? canRecord = ignore,
    Object? isPublicDataUploaded = ignore,
    Object? reviewdAt = ignore,
    Object? dissatisfactionChosenAt = ignore,
    Object? answerLaterChosenAt = ignore,
    Object? showPremiumFeaturesAdAt = ignore,
  }) {
    return collection.updateProperties(id, {
      if (totalRecordCount != ignore) 1: totalRecordCount as int?,
      if (installDate != ignore) 2: installDate as DateTime?,
      if (lastLogin != ignore) 3: lastLogin as DateTime?,
      if (totalLoginDays != ignore) 4: totalLoginDays as int?,
      if (canRecord != ignore) 5: canRecord as bool?,
      if (isPublicDataUploaded != ignore) 6: isPublicDataUploaded as bool?,
      if (reviewdAt != ignore) 7: reviewdAt as DateTime?,
      if (dissatisfactionChosenAt != ignore)
        8: dissatisfactionChosenAt as DateTime?,
      if (answerLaterChosenAt != ignore) 9: answerLaterChosenAt as DateTime?,
      if (showPremiumFeaturesAdAt != ignore)
        10: showPremiumFeaturesAdAt as DateTime?,
    });
  }
}

extension UserActivityLogUpdate on IsarCollection<int, UserActivityLog> {
  _UserActivityLogUpdate get update => _UserActivityLogUpdateImpl(this);

  _UserActivityLogUpdateAll get updateAll =>
      _UserActivityLogUpdateAllImpl(this);
}

sealed class _UserActivityLogQueryUpdate {
  int call({
    int? totalRecordCount,
    DateTime? installDate,
    DateTime? lastLogin,
    int? totalLoginDays,
    bool? canRecord,
    bool? isPublicDataUploaded,
    DateTime? reviewdAt,
    DateTime? dissatisfactionChosenAt,
    DateTime? answerLaterChosenAt,
    DateTime? showPremiumFeaturesAdAt,
  });
}

class _UserActivityLogQueryUpdateImpl implements _UserActivityLogQueryUpdate {
  const _UserActivityLogQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<UserActivityLog> query;
  final int? limit;

  @override
  int call({
    Object? totalRecordCount = ignore,
    Object? installDate = ignore,
    Object? lastLogin = ignore,
    Object? totalLoginDays = ignore,
    Object? canRecord = ignore,
    Object? isPublicDataUploaded = ignore,
    Object? reviewdAt = ignore,
    Object? dissatisfactionChosenAt = ignore,
    Object? answerLaterChosenAt = ignore,
    Object? showPremiumFeaturesAdAt = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (totalRecordCount != ignore) 1: totalRecordCount as int?,
      if (installDate != ignore) 2: installDate as DateTime?,
      if (lastLogin != ignore) 3: lastLogin as DateTime?,
      if (totalLoginDays != ignore) 4: totalLoginDays as int?,
      if (canRecord != ignore) 5: canRecord as bool?,
      if (isPublicDataUploaded != ignore) 6: isPublicDataUploaded as bool?,
      if (reviewdAt != ignore) 7: reviewdAt as DateTime?,
      if (dissatisfactionChosenAt != ignore)
        8: dissatisfactionChosenAt as DateTime?,
      if (answerLaterChosenAt != ignore) 9: answerLaterChosenAt as DateTime?,
      if (showPremiumFeaturesAdAt != ignore)
        10: showPremiumFeaturesAdAt as DateTime?,
    });
  }
}

extension UserActivityLogQueryUpdate on IsarQuery<UserActivityLog> {
  _UserActivityLogQueryUpdate get updateFirst =>
      _UserActivityLogQueryUpdateImpl(this, limit: 1);

  _UserActivityLogQueryUpdate get updateAll =>
      _UserActivityLogQueryUpdateImpl(this);
}

class _UserActivityLogQueryBuilderUpdateImpl
    implements _UserActivityLogQueryUpdate {
  const _UserActivityLogQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<UserActivityLog, UserActivityLog, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? totalRecordCount = ignore,
    Object? installDate = ignore,
    Object? lastLogin = ignore,
    Object? totalLoginDays = ignore,
    Object? canRecord = ignore,
    Object? isPublicDataUploaded = ignore,
    Object? reviewdAt = ignore,
    Object? dissatisfactionChosenAt = ignore,
    Object? answerLaterChosenAt = ignore,
    Object? showPremiumFeaturesAdAt = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (totalRecordCount != ignore) 1: totalRecordCount as int?,
        if (installDate != ignore) 2: installDate as DateTime?,
        if (lastLogin != ignore) 3: lastLogin as DateTime?,
        if (totalLoginDays != ignore) 4: totalLoginDays as int?,
        if (canRecord != ignore) 5: canRecord as bool?,
        if (isPublicDataUploaded != ignore) 6: isPublicDataUploaded as bool?,
        if (reviewdAt != ignore) 7: reviewdAt as DateTime?,
        if (dissatisfactionChosenAt != ignore)
          8: dissatisfactionChosenAt as DateTime?,
        if (answerLaterChosenAt != ignore) 9: answerLaterChosenAt as DateTime?,
        if (showPremiumFeaturesAdAt != ignore)
          10: showPremiumFeaturesAdAt as DateTime?,
      });
    } finally {
      q.close();
    }
  }
}

extension UserActivityLogQueryBuilderUpdate
    on QueryBuilder<UserActivityLog, UserActivityLog, QOperations> {
  _UserActivityLogQueryUpdate get updateFirst =>
      _UserActivityLogQueryBuilderUpdateImpl(this, limit: 1);

  _UserActivityLogQueryUpdate get updateAll =>
      _UserActivityLogQueryBuilderUpdateImpl(this);
}

extension UserActivityLogQueryFilter
    on QueryBuilder<UserActivityLog, UserActivityLog, QFilterCondition> {
  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalRecordCountEqualTo(
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalRecordCountGreaterThan(
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalRecordCountGreaterThanOrEqualTo(
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalRecordCountLessThan(
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalRecordCountLessThanOrEqualTo(
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalRecordCountBetween(
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

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      installDateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      installDateGreaterThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      installDateGreaterThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      installDateLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      installDateLessThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      installDateBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      lastLoginEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      lastLoginGreaterThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      lastLoginGreaterThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      lastLoginLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      lastLoginLessThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      lastLoginBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalLoginDaysEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalLoginDaysGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalLoginDaysGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalLoginDaysLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalLoginDaysLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      totalLoginDaysBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      canRecordEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      isPublicDataUploadedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      reviewdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      reviewdAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      reviewdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      reviewdAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      reviewdAtGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      reviewdAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      reviewdAtLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      reviewdAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      dissatisfactionChosenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      dissatisfactionChosenAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      dissatisfactionChosenAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      dissatisfactionChosenAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      dissatisfactionChosenAtGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      dissatisfactionChosenAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      dissatisfactionChosenAtLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      dissatisfactionChosenAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 8,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      answerLaterChosenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      answerLaterChosenAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      answerLaterChosenAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      answerLaterChosenAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      answerLaterChosenAtGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      answerLaterChosenAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      answerLaterChosenAtLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      answerLaterChosenAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      showPremiumFeaturesAdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      showPremiumFeaturesAdAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      showPremiumFeaturesAdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      showPremiumFeaturesAdAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      showPremiumFeaturesAdAtGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      showPremiumFeaturesAdAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      showPremiumFeaturesAdAtLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterFilterCondition>
      showPremiumFeaturesAdAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension UserActivityLogQueryObject
    on QueryBuilder<UserActivityLog, UserActivityLog, QFilterCondition> {}

extension UserActivityLogQuerySortBy
    on QueryBuilder<UserActivityLog, UserActivityLog, QSortBy> {
  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByTotalRecordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByTotalRecordCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByInstallDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByInstallDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByLastLogin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByLastLoginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByTotalLoginDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByTotalLoginDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByCanRecord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByCanRecordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByIsPublicDataUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByIsPublicDataUploadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByReviewdAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByReviewdAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByDissatisfactionChosenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByDissatisfactionChosenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByAnswerLaterChosenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByAnswerLaterChosenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByShowPremiumFeaturesAdAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      sortByShowPremiumFeaturesAdAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }
}

extension UserActivityLogQuerySortThenBy
    on QueryBuilder<UserActivityLog, UserActivityLog, QSortThenBy> {
  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByTotalRecordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByTotalRecordCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByInstallDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByInstallDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByLastLogin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByLastLoginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByTotalLoginDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByTotalLoginDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByCanRecord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByCanRecordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByIsPublicDataUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByIsPublicDataUploadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByReviewdAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByReviewdAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByDissatisfactionChosenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByDissatisfactionChosenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByAnswerLaterChosenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByAnswerLaterChosenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByShowPremiumFeaturesAdAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterSortBy>
      thenByShowPremiumFeaturesAdAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }
}

extension UserActivityLogQueryWhereDistinct
    on QueryBuilder<UserActivityLog, UserActivityLog, QDistinct> {
  QueryBuilder<UserActivityLog, UserActivityLog, QAfterDistinct>
      distinctByTotalRecordCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterDistinct>
      distinctByInstallDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterDistinct>
      distinctByLastLogin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterDistinct>
      distinctByTotalLoginDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterDistinct>
      distinctByCanRecord() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterDistinct>
      distinctByIsPublicDataUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterDistinct>
      distinctByReviewdAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterDistinct>
      distinctByDissatisfactionChosenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterDistinct>
      distinctByAnswerLaterChosenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<UserActivityLog, UserActivityLog, QAfterDistinct>
      distinctByShowPremiumFeaturesAdAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }
}

extension UserActivityLogQueryProperty1
    on QueryBuilder<UserActivityLog, UserActivityLog, QProperty> {
  QueryBuilder<UserActivityLog, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<UserActivityLog, int, QAfterProperty>
      totalRecordCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UserActivityLog, DateTime, QAfterProperty>
      installDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UserActivityLog, DateTime, QAfterProperty> lastLoginProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UserActivityLog, int, QAfterProperty> totalLoginDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UserActivityLog, bool, QAfterProperty> canRecordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<UserActivityLog, bool, QAfterProperty>
      isPublicDataUploadedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<UserActivityLog, DateTime?, QAfterProperty> reviewdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<UserActivityLog, DateTime?, QAfterProperty>
      dissatisfactionChosenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<UserActivityLog, DateTime?, QAfterProperty>
      answerLaterChosenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<UserActivityLog, DateTime?, QAfterProperty>
      showPremiumFeaturesAdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

extension UserActivityLogQueryProperty2<R>
    on QueryBuilder<UserActivityLog, R, QAfterProperty> {
  QueryBuilder<UserActivityLog, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<UserActivityLog, (R, int), QAfterProperty>
      totalRecordCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UserActivityLog, (R, DateTime), QAfterProperty>
      installDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UserActivityLog, (R, DateTime), QAfterProperty>
      lastLoginProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UserActivityLog, (R, int), QAfterProperty>
      totalLoginDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UserActivityLog, (R, bool), QAfterProperty> canRecordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<UserActivityLog, (R, bool), QAfterProperty>
      isPublicDataUploadedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<UserActivityLog, (R, DateTime?), QAfterProperty>
      reviewdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<UserActivityLog, (R, DateTime?), QAfterProperty>
      dissatisfactionChosenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<UserActivityLog, (R, DateTime?), QAfterProperty>
      answerLaterChosenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<UserActivityLog, (R, DateTime?), QAfterProperty>
      showPremiumFeaturesAdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

extension UserActivityLogQueryProperty3<R1, R2>
    on QueryBuilder<UserActivityLog, (R1, R2), QAfterProperty> {
  QueryBuilder<UserActivityLog, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<UserActivityLog, (R1, R2, int), QOperations>
      totalRecordCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UserActivityLog, (R1, R2, DateTime), QOperations>
      installDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UserActivityLog, (R1, R2, DateTime), QOperations>
      lastLoginProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UserActivityLog, (R1, R2, int), QOperations>
      totalLoginDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UserActivityLog, (R1, R2, bool), QOperations>
      canRecordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<UserActivityLog, (R1, R2, bool), QOperations>
      isPublicDataUploadedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<UserActivityLog, (R1, R2, DateTime?), QOperations>
      reviewdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<UserActivityLog, (R1, R2, DateTime?), QOperations>
      dissatisfactionChosenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<UserActivityLog, (R1, R2, DateTime?), QOperations>
      answerLaterChosenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<UserActivityLog, (R1, R2, DateTime?), QOperations>
      showPremiumFeaturesAdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userActivityLogNotifierHash() =>
    r'515864ad4976ddb6a4971ce578fd8310c94cc209';

/// See also [UserActivityLogNotifier].
@ProviderFor(UserActivityLogNotifier)
final userActivityLogNotifierProvider =
    NotifierProvider<UserActivityLogNotifier, UserActivityLog>.internal(
  UserActivityLogNotifier.new,
  name: r'userActivityLogNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userActivityLogNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserActivityLogNotifier = Notifier<UserActivityLog>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
