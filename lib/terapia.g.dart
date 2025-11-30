// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terapia.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTerapiaCollection on Isar {
  IsarCollection<Terapia> get terapias => this.collection();
}

const TerapiaSchema = CollectionSchema(
  name: r'Terapia',
  id: 6384018273203516133,
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
  estimateSize: _terapiaEstimateSize,
  serialize: _terapiaSerialize,
  deserialize: _terapiaDeserialize,
  deserializeProp: _terapiaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _terapiaGetId,
  getLinks: _terapiaGetLinks,
  attach: _terapiaAttach,
  version: '3.3.0',
);

int _terapiaEstimateSize(
  Terapia object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.info.length * 3;
  bytesCount += 3 + object.nombre.length * 3;
  return bytesCount;
}

void _terapiaSerialize(
  Terapia object,
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

Terapia _terapiaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Terapia(
    editable: reader.readBool(offsets[0]),
    frecMax: reader.readLong(offsets[1]),
    frecMin: reader.readLong(offsets[2]),
    id: id,
    info: reader.readString(offsets[3]),
    nombre: reader.readString(offsets[4]),
  );
  return object;
}

P _terapiaDeserializeProp<P>(
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

Id _terapiaGetId(Terapia object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _terapiaGetLinks(Terapia object) {
  return [];
}

void _terapiaAttach(IsarCollection<dynamic> col, Id id, Terapia object) {
  object.id = id;
}

extension TerapiaQueryWhereSort on QueryBuilder<Terapia, Terapia, QWhere> {
  QueryBuilder<Terapia, Terapia, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TerapiaQueryWhere on QueryBuilder<Terapia, Terapia, QWhereClause> {
  QueryBuilder<Terapia, Terapia, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Terapia, Terapia, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterWhereClause> idBetween(
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

extension TerapiaQueryFilter
    on QueryBuilder<Terapia, Terapia, QFilterCondition> {
  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> editableEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editable',
        value: value,
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> frecMaxEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frecMax',
        value: value,
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> frecMaxGreaterThan(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> frecMaxLessThan(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> frecMaxBetween(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> frecMinEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frecMin',
        value: value,
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> frecMinGreaterThan(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> frecMinLessThan(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> frecMinBetween(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> infoEqualTo(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> infoGreaterThan(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> infoLessThan(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> infoBetween(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> infoStartsWith(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> infoEndsWith(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> infoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'info',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> infoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'info',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> infoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'info',
        value: '',
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> infoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'info',
        value: '',
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> nombreEqualTo(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> nombreGreaterThan(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> nombreLessThan(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> nombreBetween(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> nombreStartsWith(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> nombreEndsWith(
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

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> nombreContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> nombreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }
}

extension TerapiaQueryObject
    on QueryBuilder<Terapia, Terapia, QFilterCondition> {}

extension TerapiaQueryLinks
    on QueryBuilder<Terapia, Terapia, QFilterCondition> {}

extension TerapiaQuerySortBy on QueryBuilder<Terapia, Terapia, QSortBy> {
  QueryBuilder<Terapia, Terapia, QAfterSortBy> sortByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> sortByEditableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.desc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> sortByFrecMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> sortByFrecMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.desc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> sortByFrecMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> sortByFrecMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.desc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> sortByInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> sortByInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.desc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension TerapiaQuerySortThenBy
    on QueryBuilder<Terapia, Terapia, QSortThenBy> {
  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByEditableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.desc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByFrecMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByFrecMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.desc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByFrecMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByFrecMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.desc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.desc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Terapia, Terapia, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension TerapiaQueryWhereDistinct
    on QueryBuilder<Terapia, Terapia, QDistinct> {
  QueryBuilder<Terapia, Terapia, QDistinct> distinctByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editable');
    });
  }

  QueryBuilder<Terapia, Terapia, QDistinct> distinctByFrecMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frecMax');
    });
  }

  QueryBuilder<Terapia, Terapia, QDistinct> distinctByFrecMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frecMin');
    });
  }

  QueryBuilder<Terapia, Terapia, QDistinct> distinctByInfo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'info', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Terapia, Terapia, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }
}

extension TerapiaQueryProperty
    on QueryBuilder<Terapia, Terapia, QQueryProperty> {
  QueryBuilder<Terapia, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Terapia, bool, QQueryOperations> editableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editable');
    });
  }

  QueryBuilder<Terapia, int, QQueryOperations> frecMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frecMax');
    });
  }

  QueryBuilder<Terapia, int, QQueryOperations> frecMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frecMin');
    });
  }

  QueryBuilder<Terapia, String, QQueryOperations> infoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'info');
    });
  }

  QueryBuilder<Terapia, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }
}
