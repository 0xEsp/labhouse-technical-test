// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking.dto.m.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRankingDTOCollection on Isar {
  IsarCollection<RankingDTO> get rankingDTOs => this.collection();
}

const RankingDTOSchema = CollectionSchema(
  name: r'RankingDTO',
  id: -8045715367775329464,
  properties: {
    r'articles': PropertySchema(
      id: 0,
      name: r'articles',
      type: IsarType.objectList,

      target: r'RankingArticleDTO',
    ),
    r'comments': PropertySchema(id: 1, name: r'comments', type: IsarType.long),
    r'provider': PropertySchema(
      id: 2,
      name: r'provider',
      type: IsarType.object,

      target: r'RankingProviderDTO',
    ),
    r'topicDescription': PropertySchema(
      id: 3,
      name: r'topicDescription',
      type: IsarType.string,
    ),
    r'topicImage': PropertySchema(
      id: 4,
      name: r'topicImage',
      type: IsarType.string,
    ),
    r'topicName': PropertySchema(
      id: 5,
      name: r'topicName',
      type: IsarType.string,
    ),
  },

  estimateSize: _rankingDTOEstimateSize,
  serialize: _rankingDTOSerialize,
  deserialize: _rankingDTODeserialize,
  deserializeProp: _rankingDTODeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'RankingProviderDTO': RankingProviderDTOSchema,
    r'RankingArticleDTO': RankingArticleDTOSchema,
    r'RankingRatingDTO': RankingRatingDTOSchema,
  },

  getId: _rankingDTOGetId,
  getLinks: _rankingDTOGetLinks,
  attach: _rankingDTOAttach,
  version: '3.3.2',
);

int _rankingDTOEstimateSize(
  RankingDTO object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.articles.length * 3;
  {
    final offsets = allOffsets[RankingArticleDTO]!;
    for (var i = 0; i < object.articles.length; i++) {
      final value = object.articles[i];
      bytesCount += RankingArticleDTOSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount +=
      3 +
      RankingProviderDTOSchema.estimateSize(
        object.provider,
        allOffsets[RankingProviderDTO]!,
        allOffsets,
      );
  bytesCount += 3 + object.topicDescription.length * 3;
  bytesCount += 3 + object.topicImage.length * 3;
  bytesCount += 3 + object.topicName.length * 3;
  return bytesCount;
}

void _rankingDTOSerialize(
  RankingDTO object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<RankingArticleDTO>(
    offsets[0],
    allOffsets,
    RankingArticleDTOSchema.serialize,
    object.articles,
  );
  writer.writeLong(offsets[1], object.comments);
  writer.writeObject<RankingProviderDTO>(
    offsets[2],
    allOffsets,
    RankingProviderDTOSchema.serialize,
    object.provider,
  );
  writer.writeString(offsets[3], object.topicDescription);
  writer.writeString(offsets[4], object.topicImage);
  writer.writeString(offsets[5], object.topicName);
}

RankingDTO _rankingDTODeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RankingDTO(
    articles:
        reader.readObjectList<RankingArticleDTO>(
          offsets[0],
          RankingArticleDTOSchema.deserialize,
          allOffsets,
          RankingArticleDTO(),
        ) ??
        [],
    comments: reader.readLong(offsets[1]),
    provider:
        reader.readObjectOrNull<RankingProviderDTO>(
          offsets[2],
          RankingProviderDTOSchema.deserialize,
          allOffsets,
        ) ??
        RankingProviderDTO(),
    topicDescription: reader.readString(offsets[3]),
    topicImage: reader.readString(offsets[4]),
    topicName: reader.readString(offsets[5]),
  );
  object.id = id;
  return object;
}

P _rankingDTODeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<RankingArticleDTO>(
                offset,
                RankingArticleDTOSchema.deserialize,
                allOffsets,
                RankingArticleDTO(),
              ) ??
              [])
          as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<RankingProviderDTO>(
                offset,
                RankingProviderDTOSchema.deserialize,
                allOffsets,
              ) ??
              RankingProviderDTO())
          as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _rankingDTOGetId(RankingDTO object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _rankingDTOGetLinks(RankingDTO object) {
  return [];
}

void _rankingDTOAttach(IsarCollection<dynamic> col, Id id, RankingDTO object) {
  object.id = id;
}

extension RankingDTOQueryWhereSort
    on QueryBuilder<RankingDTO, RankingDTO, QWhere> {
  QueryBuilder<RankingDTO, RankingDTO, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RankingDTOQueryWhere
    on QueryBuilder<RankingDTO, RankingDTO, QWhereClause> {
  QueryBuilder<RankingDTO, RankingDTO, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<RankingDTO, RankingDTO, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RankingDTOQueryFilter
    on QueryBuilder<RankingDTO, RankingDTO, QFilterCondition> {
  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  articlesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'articles', length, true, length, true);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  articlesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'articles', 0, true, 0, true);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  articlesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'articles', 0, false, 999999, true);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  articlesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'articles', 0, true, length, include);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  articlesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'articles', length, include, 999999, true);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  articlesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'articles',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> commentsEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'comments', value: value),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  commentsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'comments',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> commentsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'comments',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> commentsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'comments',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicDescriptionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'topicDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicDescriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'topicDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicDescriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'topicDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicDescriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'topicDescription',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicDescriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'topicDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicDescriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'topicDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'topicDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicDescriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'topicDescription',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'topicDescription', value: ''),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'topicDescription', value: ''),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> topicImageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'topicImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicImageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'topicImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicImageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'topicImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> topicImageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'topicImage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicImageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'topicImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicImageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'topicImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicImageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'topicImage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> topicImageMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'topicImage',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicImageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'topicImage', value: ''),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicImageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'topicImage', value: ''),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> topicNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'topicName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'topicName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> topicNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'topicName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> topicNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'topicName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'topicName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> topicNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'topicName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> topicNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'topicName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> topicNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'topicName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'topicName', value: ''),
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition>
  topicNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'topicName', value: ''),
      );
    });
  }
}

extension RankingDTOQueryObject
    on QueryBuilder<RankingDTO, RankingDTO, QFilterCondition> {
  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> articlesElement(
    FilterQuery<RankingArticleDTO> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'articles');
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterFilterCondition> provider(
    FilterQuery<RankingProviderDTO> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'provider');
    });
  }
}

extension RankingDTOQueryLinks
    on QueryBuilder<RankingDTO, RankingDTO, QFilterCondition> {}

extension RankingDTOQuerySortBy
    on QueryBuilder<RankingDTO, RankingDTO, QSortBy> {
  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> sortByComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comments', Sort.asc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> sortByCommentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comments', Sort.desc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> sortByTopicDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicDescription', Sort.asc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy>
  sortByTopicDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicDescription', Sort.desc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> sortByTopicImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicImage', Sort.asc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> sortByTopicImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicImage', Sort.desc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> sortByTopicName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicName', Sort.asc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> sortByTopicNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicName', Sort.desc);
    });
  }
}

extension RankingDTOQuerySortThenBy
    on QueryBuilder<RankingDTO, RankingDTO, QSortThenBy> {
  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> thenByComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comments', Sort.asc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> thenByCommentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comments', Sort.desc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> thenByTopicDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicDescription', Sort.asc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy>
  thenByTopicDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicDescription', Sort.desc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> thenByTopicImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicImage', Sort.asc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> thenByTopicImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicImage', Sort.desc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> thenByTopicName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicName', Sort.asc);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QAfterSortBy> thenByTopicNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topicName', Sort.desc);
    });
  }
}

extension RankingDTOQueryWhereDistinct
    on QueryBuilder<RankingDTO, RankingDTO, QDistinct> {
  QueryBuilder<RankingDTO, RankingDTO, QDistinct> distinctByComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comments');
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QDistinct> distinctByTopicDescription({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'topicDescription',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QDistinct> distinctByTopicImage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topicImage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RankingDTO, RankingDTO, QDistinct> distinctByTopicName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topicName', caseSensitive: caseSensitive);
    });
  }
}

extension RankingDTOQueryProperty
    on QueryBuilder<RankingDTO, RankingDTO, QQueryProperty> {
  QueryBuilder<RankingDTO, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RankingDTO, List<RankingArticleDTO>, QQueryOperations>
  articlesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'articles');
    });
  }

  QueryBuilder<RankingDTO, int, QQueryOperations> commentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comments');
    });
  }

  QueryBuilder<RankingDTO, RankingProviderDTO, QQueryOperations>
  providerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'provider');
    });
  }

  QueryBuilder<RankingDTO, String, QQueryOperations>
  topicDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topicDescription');
    });
  }

  QueryBuilder<RankingDTO, String, QQueryOperations> topicImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topicImage');
    });
  }

  QueryBuilder<RankingDTO, String, QQueryOperations> topicNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topicName');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RankingProviderDTOSchema = Schema(
  name: r'RankingProviderDTO',
  id: -3272705368355508023,
  properties: {
    r'image': PropertySchema(id: 0, name: r'image', type: IsarType.string),
    r'name': PropertySchema(id: 1, name: r'name', type: IsarType.string),
  },

  estimateSize: _rankingProviderDTOEstimateSize,
  serialize: _rankingProviderDTOSerialize,
  deserialize: _rankingProviderDTODeserialize,
  deserializeProp: _rankingProviderDTODeserializeProp,
);

int _rankingProviderDTOEstimateSize(
  RankingProviderDTO object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _rankingProviderDTOSerialize(
  RankingProviderDTO object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.image);
  writer.writeString(offsets[1], object.name);
}

RankingProviderDTO _rankingProviderDTODeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RankingProviderDTO(
    image: reader.readStringOrNull(offsets[0]),
    name: reader.readStringOrNull(offsets[1]) ?? '',
  );
  return object;
}

P _rankingProviderDTODeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RankingProviderDTOQueryFilter
    on QueryBuilder<RankingProviderDTO, RankingProviderDTO, QFilterCondition> {
  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'image'),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'image'),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'image',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'image',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'image', value: ''),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'image', value: ''),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  nameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<RankingProviderDTO, RankingProviderDTO, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }
}

extension RankingProviderDTOQueryObject
    on QueryBuilder<RankingProviderDTO, RankingProviderDTO, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RankingArticleDTOSchema = Schema(
  name: r'RankingArticleDTO',
  id: -2818308166900959957,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'image': PropertySchema(id: 1, name: r'image', type: IsarType.string),
    r'name': PropertySchema(id: 2, name: r'name', type: IsarType.string),
    r'rating': PropertySchema(
      id: 3,
      name: r'rating',
      type: IsarType.object,

      target: r'RankingRatingDTO',
    ),
  },

  estimateSize: _rankingArticleDTOEstimateSize,
  serialize: _rankingArticleDTOSerialize,
  deserialize: _rankingArticleDTODeserialize,
  deserializeProp: _rankingArticleDTODeserializeProp,
);

int _rankingArticleDTOEstimateSize(
  RankingArticleDTO object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount +=
      3 +
      RankingRatingDTOSchema.estimateSize(
        object.rating,
        allOffsets[RankingRatingDTO]!,
        allOffsets,
      );
  return bytesCount;
}

void _rankingArticleDTOSerialize(
  RankingArticleDTO object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeString(offsets[1], object.image);
  writer.writeString(offsets[2], object.name);
  writer.writeObject<RankingRatingDTO>(
    offsets[3],
    allOffsets,
    RankingRatingDTOSchema.serialize,
    object.rating,
  );
}

RankingArticleDTO _rankingArticleDTODeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RankingArticleDTO(
    description: reader.readStringOrNull(offsets[0]) ?? '',
    image: reader.readStringOrNull(offsets[1]),
    name: reader.readStringOrNull(offsets[2]) ?? '',
    rating:
        reader.readObjectOrNull<RankingRatingDTO>(
          offsets[3],
          RankingRatingDTOSchema.deserialize,
          allOffsets,
        ) ??
        const RankingRatingDTO(),
  );
  return object;
}

P _rankingArticleDTODeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readObjectOrNull<RankingRatingDTO>(
                offset,
                RankingRatingDTOSchema.deserialize,
                allOffsets,
              ) ??
              const RankingRatingDTO())
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RankingArticleDTOQueryFilter
    on QueryBuilder<RankingArticleDTO, RankingArticleDTO, QFilterCondition> {
  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  descriptionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'description',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  descriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'description',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'image'),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'image'),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'image',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'image',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'image',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'image', value: ''),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'image', value: ''),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  nameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }
}

extension RankingArticleDTOQueryObject
    on QueryBuilder<RankingArticleDTO, RankingArticleDTO, QFilterCondition> {
  QueryBuilder<RankingArticleDTO, RankingArticleDTO, QAfterFilterCondition>
  rating(FilterQuery<RankingRatingDTO> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'rating');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RankingRatingDTOSchema = Schema(
  name: r'RankingRatingDTO',
  id: 8154223992943416724,
  properties: {
    r'quantity': PropertySchema(id: 0, name: r'quantity', type: IsarType.long),
    r'value': PropertySchema(id: 1, name: r'value', type: IsarType.double),
  },

  estimateSize: _rankingRatingDTOEstimateSize,
  serialize: _rankingRatingDTOSerialize,
  deserialize: _rankingRatingDTODeserialize,
  deserializeProp: _rankingRatingDTODeserializeProp,
);

int _rankingRatingDTOEstimateSize(
  RankingRatingDTO object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _rankingRatingDTOSerialize(
  RankingRatingDTO object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.quantity);
  writer.writeDouble(offsets[1], object.value);
}

RankingRatingDTO _rankingRatingDTODeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RankingRatingDTO(
    quantity: reader.readLongOrNull(offsets[0]) ?? 0,
    value: reader.readDoubleOrNull(offsets[1]) ?? 0,
  );
  return object;
}

P _rankingRatingDTODeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RankingRatingDTOQueryFilter
    on QueryBuilder<RankingRatingDTO, RankingRatingDTO, QFilterCondition> {
  QueryBuilder<RankingRatingDTO, RankingRatingDTO, QAfterFilterCondition>
  quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'quantity', value: value),
      );
    });
  }

  QueryBuilder<RankingRatingDTO, RankingRatingDTO, QAfterFilterCondition>
  quantityGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'quantity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RankingRatingDTO, RankingRatingDTO, QAfterFilterCondition>
  quantityLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'quantity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RankingRatingDTO, RankingRatingDTO, QAfterFilterCondition>
  quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'quantity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RankingRatingDTO, RankingRatingDTO, QAfterFilterCondition>
  valueEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'value',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RankingRatingDTO, RankingRatingDTO, QAfterFilterCondition>
  valueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'value',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RankingRatingDTO, RankingRatingDTO, QAfterFilterCondition>
  valueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'value',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RankingRatingDTO, RankingRatingDTO, QAfterFilterCondition>
  valueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'value',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension RankingRatingDTOQueryObject
    on QueryBuilder<RankingRatingDTO, RankingRatingDTO, QFilterCondition> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingDTO _$RankingDTOFromJson(Map<String, dynamic> json) => RankingDTO(
  topicImage: json['topicImage'] as String,
  topicName: json['topicName'] as String,
  topicDescription: json['topicDescription'] as String,
  provider: RankingProviderDTO.fromJson(json['provider']),
  comments: (json['comments'] as num).toInt(),
  articles: (json['articles'] as List<dynamic>)
      .map(RankingArticleDTO.fromJson)
      .toList(),
);

RankingProviderDTO _$RankingProviderDTOFromJson(Map<String, dynamic> json) =>
    RankingProviderDTO(
      name: json['name'] as String? ?? '',
      image: json['image'] as String?,
    );

RankingArticleDTO _$RankingArticleDTOFromJson(Map<String, dynamic> json) =>
    RankingArticleDTO(
      image: json['image'] as String?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      rating: json['rating'] == null
          ? const RankingRatingDTO()
          : RankingRatingDTO.fromJson(json['rating']),
    );

RankingRatingDTO _$RankingRatingDTOFromJson(Map<String, dynamic> json) =>
    RankingRatingDTO(
      value: (json['value'] as num?)?.toDouble() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );
