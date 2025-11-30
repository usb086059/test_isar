// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localuseremail.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalUserEmailCollection on Isar {
  IsarCollection<LocalUserEmail> get localUserEmails => this.collection();
}

const LocalUserEmailSchema = CollectionSchema(
  name: r'LocalUserEmail',
  id: -1212353969053860537,
  properties: {
    r'localUserEmail': PropertySchema(
      id: 0,
      name: r'localUserEmail',
      type: IsarType.string,
    )
  },
  estimateSize: _localUserEmailEstimateSize,
  serialize: _localUserEmailSerialize,
  deserialize: _localUserEmailDeserialize,
  deserializeProp: _localUserEmailDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _localUserEmailGetId,
  getLinks: _localUserEmailGetLinks,
  attach: _localUserEmailAttach,
  version: '3.3.0',
);

int _localUserEmailEstimateSize(
  LocalUserEmail object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.localUserEmail.length * 3;
  return bytesCount;
}

void _localUserEmailSerialize(
  LocalUserEmail object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.localUserEmail);
}

LocalUserEmail _localUserEmailDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalUserEmail(
    localUserEmail: reader.readString(offsets[0]),
  );
  object.id = id;
  return object;
}

P _localUserEmailDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localUserEmailGetId(LocalUserEmail object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localUserEmailGetLinks(LocalUserEmail object) {
  return [];
}

void _localUserEmailAttach(
    IsarCollection<dynamic> col, Id id, LocalUserEmail object) {
  object.id = id;
}

extension LocalUserEmailQueryWhereSort
    on QueryBuilder<LocalUserEmail, LocalUserEmail, QWhere> {
  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalUserEmailQueryWhere
    on QueryBuilder<LocalUserEmail, LocalUserEmail, QWhereClause> {
  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LocalUserEmailQueryFilter
    on QueryBuilder<LocalUserEmail, LocalUserEmail, QFilterCondition> {
  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      localUserEmailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localUserEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      localUserEmailGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localUserEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      localUserEmailLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localUserEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      localUserEmailBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localUserEmail',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      localUserEmailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localUserEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      localUserEmailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localUserEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      localUserEmailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localUserEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      localUserEmailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localUserEmail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      localUserEmailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localUserEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterFilterCondition>
      localUserEmailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localUserEmail',
        value: '',
      ));
    });
  }
}

extension LocalUserEmailQueryObject
    on QueryBuilder<LocalUserEmail, LocalUserEmail, QFilterCondition> {}

extension LocalUserEmailQueryLinks
    on QueryBuilder<LocalUserEmail, LocalUserEmail, QFilterCondition> {}

extension LocalUserEmailQuerySortBy
    on QueryBuilder<LocalUserEmail, LocalUserEmail, QSortBy> {
  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterSortBy>
      sortByLocalUserEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUserEmail', Sort.asc);
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterSortBy>
      sortByLocalUserEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUserEmail', Sort.desc);
    });
  }
}

extension LocalUserEmailQuerySortThenBy
    on QueryBuilder<LocalUserEmail, LocalUserEmail, QSortThenBy> {
  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterSortBy>
      thenByLocalUserEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUserEmail', Sort.asc);
    });
  }

  QueryBuilder<LocalUserEmail, LocalUserEmail, QAfterSortBy>
      thenByLocalUserEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUserEmail', Sort.desc);
    });
  }
}

extension LocalUserEmailQueryWhereDistinct
    on QueryBuilder<LocalUserEmail, LocalUserEmail, QDistinct> {
  QueryBuilder<LocalUserEmail, LocalUserEmail, QDistinct>
      distinctByLocalUserEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localUserEmail',
          caseSensitive: caseSensitive);
    });
  }
}

extension LocalUserEmailQueryProperty
    on QueryBuilder<LocalUserEmail, LocalUserEmail, QQueryProperty> {
  QueryBuilder<LocalUserEmail, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalUserEmail, String, QQueryOperations>
      localUserEmailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localUserEmail');
    });
  }
}
