import 'package:isar_community/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ranking.dto.m.g.dart';

@collection
@JsonSerializable(createToJson: false)
class RankingDTO {
  @JsonKey(includeFromJson: false)
  Id id = Isar.autoIncrement;

  final String topicImage, topicName, topicDescription;
  final RankingProviderDTO provider;
  final int comments;
  final List<RankingArticleDTO> articles;

  RankingDTO({
    required this.topicImage,
    required this.topicName,
    required this.topicDescription,
    required this.provider,
    required this.comments,
    required this.articles,
  });

  /// Connect the generated [_$RankingDTOFromJson] function to the `fromJson`
  /// factory.
  factory RankingDTO.fromJson(Object? json) =>
      _$RankingDTOFromJson(json as Map<String, dynamic>);
}

@embedded
@JsonSerializable(createToJson: false)
class RankingProviderDTO {
  final String name;
  final String? image;

  const RankingProviderDTO({this.name = '', this.image});

  factory RankingProviderDTO.fromJson(Object? json) =>
      _$RankingProviderDTOFromJson(json as Map<String, dynamic>);
}

@embedded
@JsonSerializable(createToJson: false)
class RankingArticleDTO {
  final String? image;
  final String name, description;
  final RankingRatingDTO rating;

  const RankingArticleDTO({
    this.image,
    this.name = '',
    this.description = '',
    this.rating = const RankingRatingDTO(),
  });

  factory RankingArticleDTO.fromJson(Object? json) =>
      _$RankingArticleDTOFromJson(json as Map<String, dynamic>);
}

@embedded
@JsonSerializable(createToJson: false)
class RankingRatingDTO {
  final double value;
  final int quantity;

  const RankingRatingDTO({this.value = 0, this.quantity = 0});

  factory RankingRatingDTO.fromJson(Object? json) =>
      _$RankingRatingDTOFromJson(json as Map<String, dynamic>);
}
