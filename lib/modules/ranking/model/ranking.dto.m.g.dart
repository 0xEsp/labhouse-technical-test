// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking.dto.m.dart';

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
      name: json['name'] as String,
      image: json['image'] as String?,
    );

RankingArticleDTO _$RankingArticleDTOFromJson(Map<String, dynamic> json) =>
    RankingArticleDTO(
      image: json['image'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      rating: RankingRatingDTO.fromJson(json['rating']),
    );

RankingRatingDTO _$RankingRatingDTOFromJson(Map<String, dynamic> json) =>
    RankingRatingDTO(
      value: (json['value'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );
