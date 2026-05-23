import 'package:flutter/material.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';

class SettingsTile extends StatelessWidget {
  // MARK: - Properties

  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback onTap;

  // MARK: - Lifecycle

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.value,
  });

  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark
        ? JGColors.darkOnSurface
        : JGColors.nightAtDisco;
    final secondaryColor = JGColors.primaryGrey50;

    return Material(
      color: Theme.of(context).cardTheme.color,
      borderRadius: LabhouseCardTheme.lowRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: LabhouseCardTheme.lowRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: JGColors.primaryTurquoise, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: LabhouseTextTheme.medium(
                    size: 16,
                    color: primaryColor,
                  ),
                ),
              ),
              if (value != null) ...[
                Expanded(
                  child: Text(
                    value!,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: LabhouseTextTheme.regular(
                      size: 14,
                      color: secondaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Icon(Icons.chevron_right, color: secondaryColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
