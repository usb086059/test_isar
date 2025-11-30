// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terapia_total.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTerapiaTotalCollection on Isar {
  IsarCollection<TerapiaTotal> get terapiaTotals => this.collection();
}

const TerapiaTotalSchema = CollectionSchema(
  name: r'TerapiaTotal',
  id: 4656823345354220587,
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
    r'idTerapiaPersonal': PropertySchema(
      id: 3,
      name: r'idTerapiaPersonal',
      type: IsarType.long,
    ),
    r'info': PropertySchema(
      id: 4,
      name: r'info',
      type: IsarType.string,
    ),
    r'nombre': PropertySchema(
      id: 5,
      name: r'nombre',
      type: IsarType.string,
    )
  },
  estimateSize: _terapiaTotalEstimateSize,
  serialize: _terapiaTotalSerialize,
  deserialize: _terapiaTotalDeserialize,
  deserializeProp: _terapiaTotalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _terapiaTotalGetId,
  getLinks: _terapiaTotalGetLinks,
  attach: _terapiaTotalAttach,
  version: '3.3.0',
);

int _terapiaTotalEstimateSize(
  TerapiaTotal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.info.length * 3;
  bytesCount += 3 + object.nombre.length * 3;
  return bytesCount;
}

void _terapiaTotalSerialize(
  TerapiaTotal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.editable);
  writer.writeLong(offsets[1], object.frecMax);
  writer.writeLong(offsets[2], object.frecMin);
  writer.writeLong(offsets[3], object.idTerapiaPersonal);
  writer.writeString(offsets[4], object.info);
  writer.writeString(offsets[5], object.nombre);
}

TerapiaTotal _terapiaTotalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TerapiaTotal(
    editable: reader.readBool(offsets[0]),
    frecMax: reader.readLong(offsets[1]),
    frecMin: reader.readLong(offsets[2]),
    idTerapiaPersonal: reader.readLong(offsets[3]),
    info: reader.readString(offsets[4]),
    nombre: reader.readString(offsets[5]),
  );
  object.id = id;
  return object;
}

P _terapiaTotalDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _terapiaTotalGetId(TerapiaTotal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _terapiaTotalGetLinks(TerapiaTotal object) {
  return [];
}

void _terapiaTotalAttach(
    IsarCollection<dynamic> col, Id id, TerapiaTotal object) {
  object.id = id;
}

extension TerapiaTotalQueryWhereSort
    on QueryBuilder<TerapiaTotal, TerapiaTotal, QWhere> {
  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TerapiaTotalQueryWhere
    on QueryBuilder<TerapiaTotal, TerapiaTotal, QWhereClause> {
  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterWhereClause> idBetween(
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

extension TerapiaTotalQueryFilter
    on QueryBuilder<TerapiaTotal, TerapiaTotal, QFilterCondition> {
  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      editableEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editable',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      frecMaxEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frecMax',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      frecMinEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frecMin',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      idTerapiaPersonalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idTerapiaPersonal',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      idTerapiaPersonalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idTerapiaPersonal',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      idTerapiaPersonalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idTerapiaPersonal',
        value: value,
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      idTerapiaPersonalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idTerapiaPersonal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> infoEqualTo(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> infoLessThan(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> infoBetween(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> infoEndsWith(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> infoContains(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> infoMatches(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      infoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'info',
        value: '',
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      infoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'info',
        value: '',
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> nombreEqualTo(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> nombreBetween(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition> nombreMatches(
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

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }
}

extension TerapiaTotalQueryObject
    on QueryBuilder<TerapiaTotal, TerapiaTotal, QFilterCondition> {}

extension TerapiaTotalQueryLinks
    on QueryBuilder<TerapiaTotal, TerapiaTotal, QFilterCondition> {}

extension TerapiaTotalQuerySortBy
    on QueryBuilder<TerapiaTotal, TerapiaTotal, QSortBy> {
  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> sortByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> sortByEditableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> sortByFrecMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> sortByFrecMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> sortByFrecMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> sortByFrecMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy>
      sortByIdTerapiaPersonal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idTerapiaPersonal', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy>
      sortByIdTerapiaPersonalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idTerapiaPersonal', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> sortByInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> sortByInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension TerapiaTotalQuerySortThenBy
    on QueryBuilder<TerapiaTotal, TerapiaTotal, QSortThenBy> {
  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByEditableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editable', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByFrecMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByFrecMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMax', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByFrecMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByFrecMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frecMin', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy>
      thenByIdTerapiaPersonal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idTerapiaPersonal', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy>
      thenByIdTerapiaPersonalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idTerapiaPersonal', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'info', Sort.desc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension TerapiaTotalQueryWhereDistinct
    on QueryBuilder<TerapiaTotal, TerapiaTotal, QDistinct> {
  QueryBuilder<TerapiaTotal, TerapiaTotal, QDistinct> distinctByEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editable');
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QDistinct> distinctByFrecMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frecMax');
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QDistinct> distinctByFrecMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frecMin');
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QDistinct>
      distinctByIdTerapiaPersonal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idTerapiaPersonal');
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QDistinct> distinctByInfo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'info', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TerapiaTotal, TerapiaTotal, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }
}

extension TerapiaTotalQueryProperty
    on QueryBuilder<TerapiaTotal, TerapiaTotal, QQueryProperty> {
  QueryBuilder<TerapiaTotal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TerapiaTotal, bool, QQueryOperations> editableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editable');
    });
  }

  QueryBuilder<TerapiaTotal, int, QQueryOperations> frecMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frecMax');
    });
  }

  QueryBuilder<TerapiaTotal, int, QQueryOperations> frecMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frecMin');
    });
  }

  QueryBuilder<TerapiaTotal, int, QQueryOperations>
      idTerapiaPersonalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idTerapiaPersonal');
    });
  }

  QueryBuilder<TerapiaTotal, String, QQueryOperations> infoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'info');
    });
  }

  QueryBuilder<TerapiaTotal, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }
}
