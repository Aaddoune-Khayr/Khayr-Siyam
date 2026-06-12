import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:khayr_siyam/models/fasting_day.dart';
import 'package:khayr_siyam/generated/app_localizations.dart';
import 'package:khayr_siyam/theme.dart';

class FastingDetailPage extends StatelessWidget {
  final FastingDay fastingDay;

  const FastingDetailPage({
    Key? key,
    required this.fastingDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.fastingDetails,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.black : Colors.white,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.black : Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  _buildDateCard(theme, localizations),
                  const SizedBox(height: 24),
                  _buildDescriptionCard(theme, localizations),
                  const SizedBox(height: 24),
                  _buildBenefitsCard(theme, localizations),
                  const SizedBox(height: 24),
                  _buildHadithCard(theme, localizations),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateCard(ThemeData theme, AppLocalizations localizations) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIconForFastingType(fastingDay.type),
                    color: theme.colorScheme.onPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fastingDay.getTitle(localizations),
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fastingDay.getDescription(localizations),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateInfo(
                    theme,
                    localizations.gregorianDate,
                    DateFormat.yMMMMd(localizations.localeName).format(fastingDay.date),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateInfo(
                    theme,
                    localizations.hijriDate,
                    '${fastingDay.hijriDate.hDay} ${fastingDay.hijriDate.longMonthName} ${fastingDay.hijriDate.hYear}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateInfo(ThemeData theme, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(ThemeData theme, AppLocalizations localizations) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.description,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _getDetailedDescription(localizations),
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitsCard(ThemeData theme, AppLocalizations localizations) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star_outline,
                  color: theme.colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.benefits,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._getBenefitsList(localizations).map((benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: theme.colorScheme.secondary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      benefit,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildHadithCard(ThemeData theme, AppLocalizations localizations) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.book_outlined,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.hadith,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Text(
                _getHadithText(localizations),
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForFastingType(FastingDayType type) {
    switch (type) {
      case FastingDayType.ramadan:
        return Icons.star;
      case FastingDayType.whiteDays:
        return Icons.brightness_5;
      case FastingDayType.mondayThursday:
        return Icons.calendar_today;
      case FastingDayType.arafat:
        return Icons.flag;
      case FastingDayType.ashura:
        return Icons.flag;
      case FastingDayType.shawwal:
        return Icons.flag;
      case FastingDayType.dhulHijjahDay:
        return Icons.flag;
      case FastingDayType.eidAlAdha:
        return Icons.flag;
      case FastingDayType.tashriqDay:
        return Icons.flag;
      default:
        return Icons.help;
    }
  }

  String _getDetailedDescription(AppLocalizations localizations) {
    switch (fastingDay.type) {
      case FastingDayType.whiteDays:
        return localizations.whiteDaysDetailedDescription;
      case FastingDayType.mondayThursday:
        return localizations.mondayThursdayDetailedDescription;
      case FastingDayType.arafat:
        return localizations.arafatDayDetailedDescription;
      case FastingDayType.ashura:
        return localizations.ashuraDayDetailedDescription;
      case FastingDayType.shawwal:
        return localizations.shawwalDaysDetailedDescription;
      case FastingDayType.dhulHijjahDay:
        return localizations.dhulHijjahDaysDetailedDescription;
      default:
        return fastingDay.getDescription(localizations);
    }
  }

  List<String> _getBenefitsList(AppLocalizations localizations) {
    switch (fastingDay.type) {
      case FastingDayType.whiteDays:
        return [
          localizations.whiteDaysBenefit1,
          localizations.whiteDaysBenefit2,
          localizations.whiteDaysBenefit3,
        ];
      case FastingDayType.mondayThursday:
        return [
          localizations.mondayThursdayBenefit1,
          localizations.mondayThursdayBenefit2,
          localizations.mondayThursdayBenefit3,
        ];
      case FastingDayType.arafat:
        return [localizations.arafatDayBenefit1];
      case FastingDayType.ashura:
        return [localizations.ashuraDayBenefit1];
      case FastingDayType.shawwal:
        return [localizations.shawwalDaysBenefit1];
      case FastingDayType.dhulHijjahDay:
        return [localizations.dhulHijjahDaysBenefit1];
      default:
        return [
          localizations.generalBenefit1,
          localizations.generalBenefit2,
          localizations.generalBenefit3,
        ];
    }
  }

  String _getHadithText(AppLocalizations localizations) {
    switch (fastingDay.type) {
      case FastingDayType.whiteDays:
        return localizations.whiteDaysHadith;
      case FastingDayType.mondayThursday:
        return localizations.mondayThursdayHadith;
      case FastingDayType.arafat:
        return localizations.arafatDayHadith;
      case FastingDayType.ashura:
        return localizations.ashuraDayHadith;
      case FastingDayType.shawwal:
        return localizations.shawwalDaysHadith;
      case FastingDayType.dhulHijjahDay:
        return localizations.dhulHijjahDaysHadith;
      default:
        return localizations.generalHadith;
    }
  }
} 