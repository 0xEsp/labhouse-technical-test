import 'package:equatable/equatable.dart';
import 'package:lab_house/modules/ranking/model/ranking.dto.m.dart';

class Ranking extends Equatable {
  final String topicImageUrl, topicName, topicDescription;
  final RankingProvider provider;
  final int comments;
  final List<RankingArticle> articles;
  final DateTime createdAt;

  const Ranking({
    required this.topicImageUrl,
    required this.topicName,
    required this.topicDescription,
    required this.provider,
    required this.comments,
    required this.articles,
    required this.createdAt,
  });

  /// Number of ranked items, surfaced for the list cell.
  int get articlesCount => articles.length;

  factory Ranking.fromDTO(RankingDTO dto) => Ranking(
    topicImageUrl: dto.topicImage,
    topicName: dto.topicName,
    topicDescription: dto.topicDescription,
    provider: RankingProvider.fromDTO(dto.provider),
    comments: dto.comments,
    articles: dto.articles.map(RankingArticle.fromDTO).toList(),
    createdAt: dto.createdAt,
  );

  @override
  List<Object?> get props => [
    topicImageUrl,
    topicName,
    topicDescription,
    provider,
    comments,
    articles,
    createdAt,
  ];
}

class RankingProvider extends Equatable {
  final String name;
  final String? imageUrl;

  const RankingProvider({required this.name, required this.imageUrl});

  factory RankingProvider.fromDTO(RankingProviderDTO dto) =>
      RankingProvider(name: dto.name, imageUrl: dto.image);

  @override
  List<Object?> get props => [name, imageUrl];
}

class RankingArticle extends Equatable {
  final String? imageUrl;
  final String name, description;
  final RankingRating rating;

  const RankingArticle({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rating,
  });

  factory RankingArticle.fromDTO(RankingArticleDTO dto) => RankingArticle(
    imageUrl: dto.image,
    name: dto.name,
    description: dto.description,
    rating: RankingRating.fromDTO(dto.rating),
  );

  @override
  List<Object?> get props => [imageUrl, name, description, rating];
}

class RankingRating extends Equatable {
  final double value;
  final int quantity;

  const RankingRating({required this.value, required this.quantity});

  factory RankingRating.fromDTO(RankingRatingDTO dto) =>
      RankingRating(value: dto.value, quantity: dto.quantity);

  @override
  List<Object?> get props => [value, quantity];
}
