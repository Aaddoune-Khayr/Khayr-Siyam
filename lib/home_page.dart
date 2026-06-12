import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khayr_siyam/models/fasting_day.dart';
import 'package:khayr_siyam/services/hijri_date_service.dart';
import 'package:khayr_siyam/services/notification_service.dart';
import 'package:khayr_siyam/calendar_page.dart';
import 'package:khayr_siyam/fasting_detail_page.dart';
import 'package:khayr_siyam/settings_page.dart';
import 'package:khayr_siyam/hadith_page.dart';
import 'package:khayr_siyam/generated/app_localizations.dart';

class HomePage extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;
  final Function(Locale) onLanguageChanged;
  const HomePage({Key? key, required this.onThemeChanged, required this.onLanguageChanged}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<FastingDay> _upcomingFastingDays = [];
  bool _isLoading = true;
  bool _isDataLoaded = false;
  FastingDay? _nextFastingDay;
  bool _hasAskedNotificationPermission = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _askNotificationPermissionOnce();
  }

  void _askNotificationPermissionOnce() async {
    if (!_hasAskedNotificationPermission) {
      _hasAskedNotificationPermission = true;
      await NotificationService.requestPermissions();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    final locale = AppLocalizations.of(context)!.localeName;
    
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      final allEvents = await HijriDateService().getFastingDaysForYear(now.year, locale);
      
      final allDays = allEvents.values.expand((days) => days).toList();

      final upcoming = allDays.where((day) {
        final dayDate = DateTime(day.date.year, day.date.month, day.date.day);
        return dayDate.isAfter(today) || dayDate.isAtSameMomentAs(today);
      }).toList();

      upcoming.sort((a, b) => a.date.compareTo(b.date));
      
      if (mounted) {
        setState(() {
          _upcomingFastingDays = upcoming;
          _nextFastingDay = upcoming.isNotEmpty ? upcoming.first : null;
          _isLoading = false;
          _isDataLoaded = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                localizations.loading,
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _buildAppBar(theme, localizations),
      body: SafeArea(
        top: false,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildHomeTab(theme, localizations),
            const CalendarPage(),
            const HadithPage(),
            SettingsPage(
              onThemeChanged: widget.onThemeChanged,
              onLanguageChanged: widget.onLanguageChanged,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(ThemeData theme, AppLocalizations localizations) {
    return AppBar(
      title: null,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: theme.scaffoldBackgroundColor,
      foregroundColor: theme.colorScheme.primary,
      flexibleSpace: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
          child: GlassTabBar(
            controller: _tabController,
            labels: [
              localizations.homeTab,
              localizations.calendarTab,
              localizations.hadithTab,
              localizations.settingsTab,
            ],
            icons: const [
              Icons.home_rounded,
              Icons.calendar_month_rounded,
              Icons.menu_book_rounded,
              Icons.settings_rounded,
            ],
            theme: theme,
          ),
        ),
      ),
      toolbarHeight: 88,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildHomeTab(ThemeData theme, AppLocalizations localizations) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNextFastingDayCard(theme, localizations),
              const SizedBox(height: 24),
              _buildSectionTitle(theme, localizations.upcomingDays),
              const SizedBox(height: 16),
              _buildUpcomingFastingDaysList(theme, localizations),
          const SizedBox(height: 24),
          _buildSectionTitle(theme, localizations.aboutFastingTitle),
          const SizedBox(height: 16),
          _buildAboutFastingCard(theme, localizations),
            ],
      ),
    );
  }

  Widget _buildNextFastingDayCard(ThemeData theme, AppLocalizations localizations) {
    if (_nextFastingDay == null) {
      return const SizedBox.shrink();
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dayDate = DateTime(_nextFastingDay!.date.year, _nextFastingDay!.date.month, _nextFastingDay!.date.day);
    final daysUntil = dayDate.difference(today).inDays;
    
    String daysUntilText;
    if (daysUntil == 0) {
      daysUntilText = ' ( ${localizations.today} )';
    } else if (daysUntil == 1) {
      daysUntilText = ' ( ${localizations.tomorrow} )';
    } else {
      daysUntilText = ' ( ${localizations.inXDays(daysUntil)} )';
    }

    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final iconColor = isDark ? Color(0xFF30E0A0) : Color(0xFF18805B);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications_active_outlined, color: iconColor, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  localizations.nextFastingDay,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${_nextFastingDay!.getTitle(localizations)} — ${DateFormat.yMMMMEEEEd(localizations.localeName).format(_nextFastingDay!.date)}$daysUntilText',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: textColor.withOpacity(0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Text(
          title,
      style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
        ),
    );
  }

  Widget _buildUpcomingFastingDaysList(ThemeData theme, AppLocalizations localizations) {
    final daysToShow = _upcomingFastingDays.skip(1).take(5).toList();

    if (daysToShow.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(localizations.noMoreUpcomingDays, textAlign: TextAlign.center),
        ),
      );
    }
    
    return Column(
      children: daysToShow.map((fastingDay) {
        final formattedDate = DateFormat.yMMMMd(localizations.localeName).format(fastingDay.date);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_getIconForFastingType(fastingDay.type), color: theme.colorScheme.primary),
            ),
            title: Text(fastingDay.getTitle(localizations), style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(formattedDate),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FastingDetailPage(fastingDay: fastingDay)),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAboutFastingCard(ThemeData theme, AppLocalizations localizations) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.aboutFastingContent,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.fastingBenefitsTitle,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBenefitItem(theme, Icons.favorite_border, localizations.benefitHealth),
            const SizedBox(height: 8),
            _buildBenefitItem(theme, Icons.self_improvement_outlined, localizations.benefitSpiritual),
            const SizedBox(height: 8),
            _buildBenefitItem(theme, Icons.psychology_outlined, localizations.benefitMental),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(ThemeData theme, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 24),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
      ],
    );
  }

  IconData _getIconForFastingType(FastingDayType type) {
    switch (type) {
      case FastingDayType.mondayThursday:
        return Icons.calendar_today_outlined;
      case FastingDayType.whiteDays:
        return Icons.brightness_7_outlined;
      case FastingDayType.arafat:
      case FastingDayType.ashura:
      case FastingDayType.shawwal:
        return Icons.star_border_outlined;
      default:
        return Icons.help_outline;
    }
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const GlassCard({
    Key? key,
    required this.child,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF1E3A2F),
                  const Color(0xFF1A2E26),
                ]
              : [
                  const Color(0xFFE8F5E9),
                  const Color(0xFFDFF2E4),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isDark
              ? const Color(0xFF30E0A0).withOpacity(0.2)
              : const Color(0xFF2E9E5E).withOpacity(0.15),
        ),
      ),
      child: child,
    );
  }
}

class GlassTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> labels;
  final List<IconData> icons;
  final ThemeData theme;
  final double borderRadius;

  const GlassTabBar({
    Key? key,
    required this.controller,
    required this.labels,
    required this.icons,
    required this.theme,
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1A1A1A)
            : Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.06),
        ),
      ),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return TabBar(
            controller: controller,
            dividerColor: Colors.transparent,
            dividerHeight: 0,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: primary.withOpacity(isDark ? 0.15 : 0.12),
            ),
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            labelPadding: EdgeInsets.zero,
            tabs: List.generate(labels.length, (index) {
              final selected = controller.index == index;
              final color = selected
                  ? primary
                  : theme.textTheme.bodyMedium?.color?.withOpacity(0.55);
              return Tab(
                height: 52,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[index], size: 22, color: color),
                    const SizedBox(height: 2),
                    Text(
                      labels[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 9.5,
                        color: color,
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}