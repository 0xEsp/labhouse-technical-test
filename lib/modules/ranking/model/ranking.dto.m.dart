import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ranking.dto.m.g.dart';

@JsonSerializable(createToJson: false)
class RankingDTO extends Equatable {
  final String topicImage, topicName, topicDescription;
  final RankingProviderDTO provider;
  final int comments;
  final List<RankingArticleDTO> articles;

  const RankingDTO({
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

  // MARK: - Equatable

  @override
  List<Object?> get props => [
    topicImage,
    topicName,
    topicDescription,
    provider,
    comments,
    articles,
  ];
}

@JsonSerializable(createToJson: false)
class RankingProviderDTO extends Equatable {
  final String name;
  final String? image;

  const RankingProviderDTO({required this.name, required this.image});

  factory RankingProviderDTO.fromJson(Object? json) =>
      _$RankingProviderDTOFromJson(json as Map<String, dynamic>);

  @override
  List<Object?> get props => [name, image];
}

@JsonSerializable(createToJson: false)
class RankingArticleDTO extends Equatable {
  final String? image;
  final String name, description;
  final RankingRatingDTO rating;

  const RankingArticleDTO({
    required this.image,
    required this.name,
    required this.description,
    required this.rating,
  });

  factory RankingArticleDTO.fromJson(Object? json) =>
      _$RankingArticleDTOFromJson(json as Map<String, dynamic>);

  @override
  List<Object?> get props => [image, name, description, rating];
}

@JsonSerializable(createToJson: false)
class RankingRatingDTO extends Equatable {
  final double value;
  final int quantity;

  const RankingRatingDTO({required this.value, required this.quantity});

  factory RankingRatingDTO.fromJson(Object? json) =>
      _$RankingRatingDTOFromJson(json as Map<String, dynamic>);

  @override
  List<Object?> get props => [value, quantity];
}
