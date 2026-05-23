import 'package:flutter/material.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';

/// Fallback shown for a ranking cover (card + detail header) when the image is
/// missing or fails to load.
class RankingCoverFallback extends StatelessWidget {
  const RankingCoverFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [JGColors.primaryTurquoise, JGColors.primaryBlue],
        ),
      ),
      child: const Center(
        child: Icon(Icons.leaderboard_rounded, color: Colors.white70, size: 56),
      ),
    );
  }
}

/// Fallback for an individual article image — same idea as the cover one but a
/// distinct palette/icon so the two read differently.
class RankingArticleFallback extends StatelessWidget {
  const RankingArticleFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [JGColors.primaryPurple, JGColors.secondaryFresa],
        ),
      ),
      child: const Center(
        child: Icon(Icons.image_rounded, color: Colors.white70, size: 28),
      ),
    );
  }
}
