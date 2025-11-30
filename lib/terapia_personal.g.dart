// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terapia_personal.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTerapiaPersonalCollection on Isar {
  IsarCollection<TerapiaPersonal> get terapiaPersonals => this.collection();
}

const TerapiaPersonalSchema = CollectionSchema(
  name: r'TerapiaPersonal',
  id: 319119087133367004,
  properties: {
    r'editable': PropertySchema(
      id: 0,
      name: r'editable',
      type: IsarType.bool,
    ),
    r'frecMax': PropertySchema(
      id: 1,
      name: r'frecMax',
      type: IsarType.long,
    ),
    r'frecMin': PropertySchema(
      id: 2,
      name: r'frecMin',
      type: IsarType.long,
    ),
    r'info': PropertySchema(
      id: 3,
      name: r'info',
      type: IsarType.string,
    ),
    r'nombre': PropertySchema(
      id: 4,
      name: r'nombre',
      type: IsarType.string,
    )
  },
  estimateSize: _terapiaPersonalEstimateSize,
  serialize: _terapiaPersonalSerialize,
  deserialize: _terapiaPersonalDeserialize,
  deserializeProp: _terapiaPersonalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _terapiaPersonalGetId,
  getLinks: _terapiaPersonalGetLinks,
  attach: _terapiaPersonalAttach,
  version: '3.3.0',
);

int _terapiaPersonalEstimateSize(
  TerapiaPersonal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.info.length * 3;
  bytesCount += 3 + object.nombre.length * 3;
  return bytesCount;
}

void _terapiaPersonalSerialize(
  TerapiaPersonal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.editable);
  writer.writeLong(offsets[1], object.frecMax);
  writer.writeLong(offsets[2], object.frecMin);
  writer.writeString(offsets[3], object.info);
  writer.writeString(offsets[4], object.nombre);
}

TerapiaPersonal _terapiaPersonalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TerapiaPersonal(
    editable: reader.readBool(offsets[0]),
    frecMax: reader.readLong(offsets[1]),
    frecMin: reader.readLong(offsets[2]),
    info: reader.readString(offsets[3]),
    nombre: reader.readString(offsets[4]),
  );
  object.id = id;
  return object;
}

P _terapiaPersonalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _terapiaPersonalGetId(TerapiaPersonal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _terapiaPersonalGetLinks(TerapiaPersonal object) {
  return [];
}

void _terapiaPersonalAttach(
    IsarCollection<dynamic> col, Id id, TerapiaPersonal object) {
  object.id = id;
}

extension TerapiaPersonalQueryWhereSort
    on QueryBuilder<TerapiaPersonal, TerapiaPersonal, QWhere> {
  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TerapiaPersonalQueryWhere
    on QueryBuilder<TerapiaPersonal, TerapiaPersonal, QWhereClause> {
  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterWhereClause> idBetween(
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

extension TerapiaPersonalQueryFilter
    on QueryBuilder<TerapiaPersonal, TerapiaPersonal, QFilterCondition> {
  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      editableEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editable',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      frecMaxEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frecMax',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      frecMaxGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frecMax',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      frecMaxLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frecMax',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      frecMaxBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frecMax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      frecMinEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frecMin',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      frecMinGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frecMin',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      frecMinLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frecMin',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      frecMinBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frecMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      infoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      infoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      infoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      infoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'info',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      infoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      infoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      infoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      infoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'info',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      infoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'info',
        value: '',
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      infoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'info',
        value: '',
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }
}

extension TerapiaPersonalQueryObject
    on QueryBuilder<TerapiaPersonal, TerapiaPersonal, QFilterCondition> {}

extension TerapiaPersonalQueryLinks
    on QueryBuilder<TerapiaPersonal, TerapiaPersonal, QFilterCondition> {}

extension TerapiaPersonalQuerySortBy
    on QueryBuilder<TerapiaPersonal, TerapiaPersonal, QSortBy> {
  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      sortByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      sortByEditableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.desc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy> sortByFrecMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      sortByFrecMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.desc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy> sortByFrecMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      sortByFrecMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.desc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy> sortByInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      sortByInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.desc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension TerapiaPersonalQuerySortThenBy
    on QueryBuilder<TerapiaPersonal, TerapiaPersonal, QSortThenBy> {
  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      thenByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      thenByEditableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.desc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy> thenByFrecMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      thenByFrecMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.desc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy> thenByFrecMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      thenByFrecMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.desc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy> thenByInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      thenByInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.desc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QAfterSortBy>
      thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension TerapiaPersonalQueryWhereDistinct
    on QueryBuilder<TerapiaPersonal, TerapiaPersonal, QDistinct> {
  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QDistinct>
      distinctByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editable');
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QDistinct>
      distinctByFrecMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frecMax');
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QDistinct>
      distinctByFrecMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frecMin');
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QDistinct> distinctByInfo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'info', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TerapiaPersonal, TerapiaPersonal, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }
}

extension TerapiaPersonalQueryProperty
    on QueryBuilder<TerapiaPersonal, TerapiaPersonal, QQueryProperty> {
  QueryBuilder<TerapiaPersonal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TerapiaPersonal, bool, QQueryOperations> editableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editable');
    });
  }

  QueryBuilder<TerapiaPersonal, int, QQueryOperations> frecMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frecMax');
    });
  }

  QueryBuilder<TerapiaPersonal, int, QQueryOperations> frecMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frecMin');
    });
  }

  QueryBuilder<TerapiaPersonal, String, QQueryOperations> infoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'info');
    });
  }

  QueryBuilder<TerapiaPersonal, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }
}
