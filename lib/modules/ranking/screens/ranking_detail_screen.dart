import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/modules/ranking/components/ranking_image_fallback.dart';
import 'package:lab_house/modules/ranking/model/ranking.m.dart';

class RankingDetailScreen extends StatelessWidget with LocaleManager {
  final Ranking ranking;

  static const String providerImageFallbackUrl =
      'https://webel-technologies.github.io/webel_web_library_components/assets/images/default/default-profile-pic.svg';

  const RankingDetailScreen({super.key, required this.ranking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          _header(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: _content(context),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - Header (sticky, collapsing cover)

  Widget _header(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 220,
      backgroundColor: JGColors.surface(context),
      automaticallyImplyLeading: false,
      leading: _circleButton(
        context,
        icon: Icons.arrow_back_ios_new_rounded,
        onTap: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: ranking.topicImageUrl,
              fit: BoxFit.cover,
              placeholder: (_, _) => ColoredBox(color: JGColors.primaryGrey20),
              errorWidget: (_, _, _) => const RankingCoverFallback(),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0x66000000)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: - Content

  Widget _content(BuildContext context) {
    final lc = locale(context);
    final onSurface = JGColors.onSurface(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: JGColors.primaryGrey20,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _provider(context),
        const SizedBox(height: 16),
        Text(
          ranking.topicName,
          style: LabhouseTextTheme.semibold(size: 26, color: onSurface),
        ),
        const SizedBox(height: 6),
        Text(
          lc.ranking_reviews_count(ranking.comments),
          style: LabhouseTextTheme.medium(
            size: 13,
            color: JGColors.primaryGrey50,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          ranking.topicDescription,
          style: LabhouseTextTheme.regular(
            size: 15,
            height: 1.5,
            color: JGColors.primaryGrey60,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          lc.ranking_articles_section,
          style: LabhouseTextTheme.semibold(size: 20, color: onSurface),
        ),
        const SizedBox(height: 16),
        ...ranking.articles.map((article) => _articleTile(context, article)),
      ],
    );
  }

  Widget _provider(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: SizedBox(width: 36, height: 36, child: _providerImage()),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            ranking.provider.name,
            overflow: TextOverflow.ellipsis,
            style: LabhouseTextTheme.semibold(
              size: 15,
              color: JGColors.onSurface(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _providerImage() {
    final url = ranking.provider.imageUrl;

    if (url == null) return _providerFallback();

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (_, _) => ColoredBox(color: JGColors.primaryGrey20),
      errorWidget: (_, _, _) => _providerFallback(),
    );
  }

  Widget _providerFallback() => SvgPicture.network(
    providerImageFallbackUrl,
    fit: BoxFit.cover,
    placeholderBuilder: (_) => ColoredBox(color: JGColors.primaryGrey20),
  );

  Widget _articleTile(BuildContext context, RankingArticle article) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 92,
              height: 92,
              child: article.imageUrl == null
                  ? const RankingArticleFallback()
                  : CachedNetworkImage(
                      imageUrl: article.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, _) =>
                          ColoredBox(color: JGColors.primaryGrey20),
                      errorWidget: (_, _, _) => const RankingArticleFallback(),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: LabhouseTextTheme.semibold(
                    size: 16,
                    color: JGColors.onSurface(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  article.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: LabhouseTextTheme.regular(
                    size: 13,
                    height: 1.4,
                    color: JGColors.primaryGrey60,
                  ),
                ),
                const SizedBox(height: 8),
                _rating(context, article),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rating(BuildContext context, RankingArticle article) {
    final lc = locale(context);

    return Row(
      children: [
        const Icon(Icons.star_rounded, size: 18, color: Color(0xFFFFC107)),
        const SizedBox(width: 4),
        Text(
          article.rating.value.toStringAsFixed(2),
          style: LabhouseTextTheme.semibold(
            size: 13,
            color: JGColors.onSurface(context),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          lc.ranking_reviews_count(article.rating.quantity),
          style: LabhouseTextTheme.regular(
            size: 12,
            color: JGColors.primaryGrey50,
          ),
        ),
      ],
    );
  }

  // MARK: - Helpers

  Widget _circleButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.black38,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
