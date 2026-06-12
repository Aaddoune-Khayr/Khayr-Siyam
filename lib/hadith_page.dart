import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:khayr_siyam/generated/app_localizations.dart';

class HadithCategory {
  final String title;
  final List<Hadith> hadiths;
  HadithCategory({required this.title, required this.hadiths});
}

class Hadith {
  final String title;
  final String body;
  Hadith({required this.title, required this.body});
}

class HadithPage extends StatelessWidget {
  const HadithPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    final List<HadithCategory> categories = [
    HadithCategory(
        title: localizations.hadithCategoryMerits,
      hadiths: [
          Hadith(title: localizations.hadithFastingShieldTitle, body: localizations.hadithFastingShieldBody),
          Hadith(title: localizations.hadithTwoJoysTitle, body: localizations.hadithTwoJoysBody),
          Hadith(title: localizations.hadithRayyanGateTitle, body: localizations.hadithRayyanGateBody),
      ],
    ),
    HadithCategory(
        title: localizations.hadithCategoryRecommended,
      hadiths: [
          Hadith(title: localizations.hadithMondayThursdayTitle, body: localizations.hadithMondayThursdayBody),
          Hadith(title: localizations.hadithWhiteDaysTitle, body: localizations.hadithWhiteDaysBody),
      ],
    ),
    HadithCategory(
        title: localizations.hadithCategorySpecial,
      hadiths: [
          Hadith(title: localizations.hadithArafatTitle, body: localizations.hadithArafatBody),
          Hadith(title: localizations.hadithAshuraTitle, body: localizations.hadithAshuraBody),
          Hadith(title: localizations.hadithShawwalTitle, body: localizations.hadithShawwalBody),
      ],
    ),
    HadithCategory(
        title: localizations.hadithCategoryForbidden,
      hadiths: [
          Hadith(title: localizations.hadithEidDaysTitle, body: localizations.hadithEidDaysBody),
          Hadith(title: localizations.hadithTashriqDaysTitle, body: localizations.hadithTashriqDaysBody),
      ],
    ),
    HadithCategory(
        title: localizations.hadithCategoryInvocations,
      hadiths: [
          Hadith(title: localizations.hadithInvocationBreakingFastTitle, body: localizations.hadithInvocationBreakingFastBody),
      ],
    ),
  ];

    return AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
        itemCount: categories.length,
          itemBuilder: (context, index) {
          final category = categories[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                child: _buildCategoryCard(theme, category),
              ),
              ),
            );
          },
      ),
    );
  }

  Widget _buildCategoryCard(ThemeData theme, HadithCategory category) {
    final titleColor = theme.colorScheme.onSurface;
    final iconColor = theme.colorScheme.primary;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.menu_book, color: iconColor),
        ),
        title: Text(
          category.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        children: category.hadiths
            .map((hadith) => _buildHadithExpansionTile(theme, hadith))
            .toList(),
      ),
    );
  }

  Widget _buildHadithExpansionTile(ThemeData theme, Hadith hadith) {
    final titleColor = theme.colorScheme.onSurface.withOpacity(0.9);
    final bodyColor = theme.colorScheme.onSurface.withOpacity(0.7);

    return Column(
      children: [
        Divider(
          height: 1,
          thickness: 1,
          color: theme.dividerColor,
          indent: 16,
          endIndent: 16,
        ),
        ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          title: Text(
            hadith.title,
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w600, color: titleColor),
          ),
          children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                hadith.body,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(height: 1.5, color: bodyColor),
              ),
            )
          ],
        ),
      ],
    );
  }
} 