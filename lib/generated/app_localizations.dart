import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Khayr Siyam'**
  String get appTitle;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @calendarTab.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarTab;

  /// No description provided for @hadithTab.
  ///
  /// In en, this message translates to:
  /// **'Hadiths'**
  String get hadithTab;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @nextFastingDay.
  ///
  /// In en, this message translates to:
  /// **'Next fasting day'**
  String get nextFastingDay;

  /// No description provided for @upcomingDays.
  ///
  /// In en, this message translates to:
  /// **'Upcoming days'**
  String get upcomingDays;

  /// No description provided for @noUpcomingDays.
  ///
  /// In en, this message translates to:
  /// **'No upcoming fasting days in the next 30 days.'**
  String get noUpcomingDays;

  /// No description provided for @aboutFasting.
  ///
  /// In en, this message translates to:
  /// **'About Fasting'**
  String get aboutFasting;

  /// No description provided for @aboutFastingDescription.
  ///
  /// In en, this message translates to:
  /// **'Voluntary fasting is a source of great reward. Here are some of its benefits:'**
  String get aboutFastingDescription;

  /// No description provided for @benefitsOfFasting.
  ///
  /// In en, this message translates to:
  /// **'Benefits of Fasting'**
  String get benefitsOfFasting;

  /// No description provided for @healthBenefit.
  ///
  /// In en, this message translates to:
  /// **'Improves physical health'**
  String get healthBenefit;

  /// No description provided for @spiritualBenefit.
  ///
  /// In en, this message translates to:
  /// **'Strengthens spirituality'**
  String get spiritualBenefit;

  /// No description provided for @mentalBenefit.
  ///
  /// In en, this message translates to:
  /// **'Develops self-discipline'**
  String get mentalBenefit;

  /// No description provided for @fastingDetails.
  ///
  /// In en, this message translates to:
  /// **'Fasting Details'**
  String get fastingDetails;

  /// No description provided for @gregorianDate.
  ///
  /// In en, this message translates to:
  /// **'Gregorian Date'**
  String get gregorianDate;

  /// No description provided for @hijriDate.
  ///
  /// In en, this message translates to:
  /// **'Hijri Date'**
  String get hijriDate;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @benefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefits;

  /// No description provided for @hadith.
  ///
  /// In en, this message translates to:
  /// **'Hadith'**
  String get hadith;

  /// No description provided for @mondayThursday.
  ///
  /// In en, this message translates to:
  /// **'Mon/Thu'**
  String get mondayThursday;

  /// No description provided for @whiteDays.
  ///
  /// In en, this message translates to:
  /// **'White Days'**
  String get whiteDays;

  /// No description provided for @arafatDay.
  ///
  /// In en, this message translates to:
  /// **'Day of Arafat'**
  String get arafatDay;

  /// No description provided for @ashuraDay.
  ///
  /// In en, this message translates to:
  /// **'Day of Ashura'**
  String get ashuraDay;

  /// No description provided for @shawwalDays.
  ///
  /// In en, this message translates to:
  /// **'6 Days of Shawwal'**
  String get shawwalDays;

  /// No description provided for @dhulHijjahDays.
  ///
  /// In en, this message translates to:
  /// **'First days of Dhul-Hijjah'**
  String get dhulHijjahDays;

  /// No description provided for @mondayThursdayDescription.
  ///
  /// In en, this message translates to:
  /// **'Recommended fasting on Mondays and Thursdays according to prophetic tradition.'**
  String get mondayThursdayDescription;

  /// No description provided for @whiteDaysDescription.
  ///
  /// In en, this message translates to:
  /// **'Fasting on the 13th, 14th, and 15th of each Hijri month (white days).'**
  String get whiteDaysDescription;

  /// No description provided for @arafatDayDescription.
  ///
  /// In en, this message translates to:
  /// **'Fasting on the Day of Arafat (9th Dhul Hijjah) - expiates sins of two years.'**
  String get arafatDayDescription;

  /// No description provided for @ashuraDayDescription.
  ///
  /// In en, this message translates to:
  /// **'Fasting on the Day of Ashura (10th Muharram) - expiates sins of the previous year.'**
  String get ashuraDayDescription;

  /// No description provided for @shawwalDaysDescription.
  ///
  /// In en, this message translates to:
  /// **'Fasting 6 days of Shawwal after Ramadan - equivalent to fasting the whole year.'**
  String get shawwalDaysDescription;

  /// No description provided for @dhulHijjahDaysDescription.
  ///
  /// In en, this message translates to:
  /// **'Fasting the first 9 days of Dhul Hijjah - among the best days of the year.'**
  String get dhulHijjahDaysDescription;

  /// No description provided for @ramadanDescription.
  ///
  /// In en, this message translates to:
  /// **'Sacred month of Ramadan - obligatory fasting for all adult Muslims.'**
  String get ramadanDescription;

  /// No description provided for @eidAlFitrDescription.
  ///
  /// In en, this message translates to:
  /// **'Feast of Breaking the Fast - fasting is forbidden on this day.'**
  String get eidAlFitrDescription;

  /// No description provided for @eidAlAdhaDescription.
  ///
  /// In en, this message translates to:
  /// **'Feast of Sacrifice - fasting is forbidden on this day.'**
  String get eidAlAdhaDescription;

  /// No description provided for @tashriqDaysDescription.
  ///
  /// In en, this message translates to:
  /// **'Tashriq Days (11th, 12th, 13th Dhul Hijjah) - fasting is forbidden.'**
  String get tashriqDaysDescription;

  /// No description provided for @whiteDaysDetailedDescription.
  ///
  /// In en, this message translates to:
  /// **'The white days correspond to the 13th, 14th, and 15th of each lunar month. These days are called \'white\' because the moon is full and illuminates the night. Fasting these three days is equivalent to fasting a whole month, making it a very meritorious practice.'**
  String get whiteDaysDetailedDescription;

  /// No description provided for @mondayThursdayDetailedDescription.
  ///
  /// In en, this message translates to:
  /// **'The Prophet (peace be upon him) used to fast on Mondays and Thursdays. These days are particularly recommended because the deeds of the servants are presented to Allah on these days.'**
  String get mondayThursdayDetailedDescription;

  /// No description provided for @arafatDayDetailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Fasting on the Day of Arafat is a day of prayer and reflection for Muslims.'**
  String get arafatDayDetailedDescription;

  /// No description provided for @ashuraDayDetailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Fasting on Ashura Day is a day of prayer and reflection for Muslims.'**
  String get ashuraDayDetailedDescription;

  /// No description provided for @shawwalDaysDetailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Fasting on Shawwal is a day of prayer and reflection for Muslims.'**
  String get shawwalDaysDetailedDescription;

  /// No description provided for @dhulHijjahDaysDetailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Fasting on Dhul Hijjah is a day of prayer and reflection for Muslims.'**
  String get dhulHijjahDaysDetailedDescription;

  /// No description provided for @whiteDaysBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Equivalent to fasting a whole month'**
  String get whiteDaysBenefit1;

  /// No description provided for @whiteDaysBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Expiates sins'**
  String get whiteDaysBenefit2;

  /// No description provided for @whiteDaysBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Increases reward'**
  String get whiteDaysBenefit3;

  /// No description provided for @mondayThursdayBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Deeds are presented to Allah'**
  String get mondayThursdayBenefit1;

  /// No description provided for @mondayThursdayBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Recommended regular practice'**
  String get mondayThursdayBenefit2;

  /// No description provided for @mondayThursdayBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Easy to maintain'**
  String get mondayThursdayBenefit3;

  /// No description provided for @arafatDayBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Day of prayer and reflection'**
  String get arafatDayBenefit1;

  /// No description provided for @ashuraDayBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Day of prayer and reflection'**
  String get ashuraDayBenefit1;

  /// No description provided for @shawwalDaysBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Day of prayer and reflection'**
  String get shawwalDaysBenefit1;

  /// No description provided for @dhulHijjahDaysBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Day of prayer and reflection'**
  String get dhulHijjahDaysBenefit1;

  /// No description provided for @generalBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Spiritual benefits'**
  String get generalBenefit1;

  /// No description provided for @generalBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Divine reward'**
  String get generalBenefit2;

  /// No description provided for @generalBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Purification of the soul'**
  String get generalBenefit3;

  /// No description provided for @whiteDaysHadith.
  ///
  /// In en, this message translates to:
  /// **'According to \'Abdel Malik Ibn Qudama Ibn Malhan, from his father (may Allah be pleased with them), the Prophet (peace and blessings of Allah be upon him) ordered us to fast the white days, the 13th, 14th, and 15th and he said: \'This is like fasting the whole month.\' (Reported by Nasai and authenticated by Sheikh Albani in Sahih Taghrib No. 1039)'**
  String get whiteDaysHadith;

  /// No description provided for @mondayThursdayHadith.
  ///
  /// In en, this message translates to:
  /// **'According to Hounayda Bint Khalid (may Allah be pleased with her), from one of the wives of the Prophet (peace and blessings of Allah be upon him), the Prophet (peace and blessings of Allah be upon him) used to fast the nine days of Dhul Hijjah, the day of Ashura, and three days each month: the first Monday of the month and two Thursdays.'**
  String get mondayThursdayHadith;

  /// No description provided for @arafatDayHadith.
  ///
  /// In en, this message translates to:
  /// **'Fasting on the Day of Arafat is an important prayer for Muslims.'**
  String get arafatDayHadith;

  /// No description provided for @ashuraDayHadith.
  ///
  /// In en, this message translates to:
  /// **'Fasting on Ashura Day is an important prayer for Muslims.'**
  String get ashuraDayHadith;

  /// No description provided for @shawwalDaysHadith.
  ///
  /// In en, this message translates to:
  /// **'Fasting on Shawwal is an important prayer for Muslims.'**
  String get shawwalDaysHadith;

  /// No description provided for @dhulHijjahDaysHadith.
  ///
  /// In en, this message translates to:
  /// **'Fasting on Dhul Hijjah is an important prayer for Muslims.'**
  String get dhulHijjahDaysHadith;

  /// No description provided for @generalHadith.
  ///
  /// In en, this message translates to:
  /// **'Fasting is an important spiritual practice in Islam that purifies the soul and brings the believer closer to Allah.'**
  String get generalHadith;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationTime.
  ///
  /// In en, this message translates to:
  /// **'Notification time'**
  String get notificationTime;

  /// No description provided for @notificationTimeDescription.
  ///
  /// In en, this message translates to:
  /// **'Receive reminders the day before fasting day'**
  String get notificationTimeDescription;

  /// No description provided for @notificationDaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Days before notification'**
  String get notificationDaysTitle;

  /// No description provided for @notificationDaysSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how many days before fasting you want to be notified'**
  String get notificationDaysSubtitle;

  /// No description provided for @notificationTypesTitle.
  ///
  /// In en, this message translates to:
  /// **'Fasting types to monitor'**
  String get notificationTypesTitle;

  /// No description provided for @resetSettings.
  ///
  /// In en, this message translates to:
  /// **'Reset settings'**
  String get resetSettings;

  /// No description provided for @resetConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset settings?'**
  String get resetConfirmationTitle;

  /// No description provided for @resetConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'This will reset all settings to their default values. This action cannot be undone.'**
  String get resetConfirmationMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @selectFastingType.
  ///
  /// In en, this message translates to:
  /// **'Select Fasting Type'**
  String get selectFastingType;

  /// No description provided for @calendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Fasting Calendar'**
  String get calendarTitle;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @inXDays.
  ///
  /// In en, this message translates to:
  /// **'in {count} days'**
  String inXDays(int count);

  /// No description provided for @hadithPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Prophetic Hadiths'**
  String get hadithPageTitle;

  /// No description provided for @hadithFastingShieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Fasting is a Shield'**
  String get hadithFastingShieldTitle;

  /// No description provided for @hadithFastingShieldBody.
  ///
  /// In en, this message translates to:
  /// **'The Messenger of Allah (ﷺ) said, \'Fasting is a shield (or a screen or a shelter). So, the person observing fasting should avoid sexual relation with his wife and should not behave foolishly and impudently, and if somebody fights with him or abuses him, he should say to him twice, \'I am fasting.\' The Prophet added, \'By Him in Whose Hands my soul is, the smell coming out from the mouth of a fasting person is better in the sight of Allah than the smell of musk. (Allah says about the fasting person), \'He has left his food, drink and desires for My sake. The fast is for Me. So I will reward (the fasting person) for it and the reward of good deeds is multiplied ten times.\''**
  String get hadithFastingShieldBody;

  /// No description provided for @hadithTwoJoysTitle.
  ///
  /// In en, this message translates to:
  /// **'The Two Joys for the Fasting Person'**
  String get hadithTwoJoysTitle;

  /// No description provided for @hadithTwoJoysBody.
  ///
  /// In en, this message translates to:
  /// **'The Messenger of Allah (ﷺ) said, \'There are two joys for the fasting person: the joy when he breaks his fast and the joy when he meets his Lord.\''**
  String get hadithTwoJoysBody;

  /// No description provided for @hadithRayyanGateTitle.
  ///
  /// In en, this message translates to:
  /// **'The Gate of Rayyan'**
  String get hadithRayyanGateTitle;

  /// No description provided for @hadithRayyanGateBody.
  ///
  /// In en, this message translates to:
  /// **'The Prophet (ﷺ) said, \'There is a gate in Paradise called Ar-Raiyan, and those who observe fasts will enter through it on the Day of Resurrection and none except them will enter through it. It will be said, \'Where are those who used to observe fasts?\' They will get up, and none except them will enter through it. After their entry the gate will be closed and nobody will enter through it.\''**
  String get hadithRayyanGateBody;

  /// No description provided for @hadithMonthOfPatienceTitle.
  ///
  /// In en, this message translates to:
  /// **'The Month of Patience'**
  String get hadithMonthOfPatienceTitle;

  /// No description provided for @hadithMonthOfPatienceBody.
  ///
  /// In en, this message translates to:
  /// **'The Messenger of Allah (ﷺ) said, \'Fasting the month of patience (Ramadan) and three days of every month is equivalent to fasting for a lifetime.\''**
  String get hadithMonthOfPatienceBody;

  /// No description provided for @hadithExpiationTitle.
  ///
  /// In en, this message translates to:
  /// **'Fasting as Expiation'**
  String get hadithExpiationTitle;

  /// No description provided for @hadithExpiationBody.
  ///
  /// In en, this message translates to:
  /// **'The Messenger of Allah (ﷺ) said, \'The performance of `Umra is an expiation for the sins committed (between it and the previous one). And the reward of Hajj Mabrur (the one accepted by Allah) is nothing except Paradise.'**
  String get hadithExpiationBody;

  /// No description provided for @hadithCategoryMerits.
  ///
  /// In en, this message translates to:
  /// **'The Merits of Fasting'**
  String get hadithCategoryMerits;

  /// No description provided for @hadithCategoryRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended Fasting Days'**
  String get hadithCategoryRecommended;

  /// No description provided for @hadithCategorySpecial.
  ///
  /// In en, this message translates to:
  /// **'Special Days'**
  String get hadithCategorySpecial;

  /// No description provided for @hadithCategoryForbidden.
  ///
  /// In en, this message translates to:
  /// **'Forbidden Days'**
  String get hadithCategoryForbidden;

  /// No description provided for @hadithCategoryInvocations.
  ///
  /// In en, this message translates to:
  /// **'Invocations of Fasting'**
  String get hadithCategoryInvocations;

  /// No description provided for @hadithMondayThursdayTitle.
  ///
  /// In en, this message translates to:
  /// **'Monday and Thursday'**
  String get hadithMondayThursdayTitle;

  /// No description provided for @hadithMondayThursdayBody.
  ///
  /// In en, this message translates to:
  /// **'The Prophet (peace be upon him) said: \'The deeds of people are presented to Allah on Mondays and Thursdays, and I like my deeds to be presented while I am fasting.\''**
  String get hadithMondayThursdayBody;

  /// No description provided for @hadithWhiteDaysTitle.
  ///
  /// In en, this message translates to:
  /// **'The White Days'**
  String get hadithWhiteDaysTitle;

  /// No description provided for @hadithWhiteDaysBody.
  ///
  /// In en, this message translates to:
  /// **'The Prophet (peace be upon him) said: \'Fasting three days of each month is like fasting for a lifetime, and the white days are the thirteenth, fourteenth, and fifteenth.\''**
  String get hadithWhiteDaysBody;

  /// No description provided for @hadithArafatTitle.
  ///
  /// In en, this message translates to:
  /// **'Day of Arafat'**
  String get hadithArafatTitle;

  /// No description provided for @hadithArafatBody.
  ///
  /// In en, this message translates to:
  /// **'Fasting on the Day of Arafat expiates the sins of the preceding year and the coming year.'**
  String get hadithArafatBody;

  /// No description provided for @hadithAshuraTitle.
  ///
  /// In en, this message translates to:
  /// **'Day of Ashura'**
  String get hadithAshuraTitle;

  /// No description provided for @hadithAshuraBody.
  ///
  /// In en, this message translates to:
  /// **'Fasting on the Day of Ashura expiates the sins of the preceding year.'**
  String get hadithAshuraBody;

  /// No description provided for @hadithShawwalTitle.
  ///
  /// In en, this message translates to:
  /// **'Six Days of Shawwal'**
  String get hadithShawwalTitle;

  /// No description provided for @hadithShawwalBody.
  ///
  /// In en, this message translates to:
  /// **'Whoever fasts Ramadan and follows it with six days of Shawwal, it will be as if he fasted for a lifetime.'**
  String get hadithShawwalBody;

  /// No description provided for @hadithEidDaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Eid Days'**
  String get hadithEidDaysTitle;

  /// No description provided for @hadithEidDaysBody.
  ///
  /// In en, this message translates to:
  /// **'The Prophet (peace be upon him) forbade fasting on the day of Eid al-Fitr and the day of Eid al-Adha.'**
  String get hadithEidDaysBody;

  /// No description provided for @hadithTashriqDaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Days of Tashriq'**
  String get hadithTashriqDaysTitle;

  /// No description provided for @hadithTashriqDaysBody.
  ///
  /// In en, this message translates to:
  /// **'The days of Tashriq (11th, 12th, and 13th of Dhul-Hijjah) are days of eating, drinking, and remembering Allah.'**
  String get hadithTashriqDaysBody;

  /// No description provided for @hadithInvocationBreakingFastTitle.
  ///
  /// In en, this message translates to:
  /// **'Invocation when Breaking the Fast'**
  String get hadithInvocationBreakingFastTitle;

  /// No description provided for @hadithInvocationBreakingFastBody.
  ///
  /// In en, this message translates to:
  /// **'When breaking the fast, the Prophet (peace be upon him) used to say: \'Dhahaba al-zama\' wa abtallat al-\'uruq wa thabata al-ajr in sha Allah\' (The thirst is gone, the veins are moistened, and the reward is confirmed, if Allah wills).'**
  String get hadithInvocationBreakingFastBody;

  /// No description provided for @markAsFasted.
  ///
  /// In en, this message translates to:
  /// **'Mark as Fasted'**
  String get markAsFasted;

  /// No description provided for @unmarkAsFasted.
  ///
  /// In en, this message translates to:
  /// **'Unmark as Fasted'**
  String get unmarkAsFasted;

  /// No description provided for @fastedDaysLegend.
  ///
  /// In en, this message translates to:
  /// **'Fasted'**
  String get fastedDaysLegend;

  /// No description provided for @noRecommendedFasting.
  ///
  /// In en, this message translates to:
  /// **'No recommended fasting for this day.'**
  String get noRecommendedFasting;

  /// No description provided for @markDayAsFasted.
  ///
  /// In en, this message translates to:
  /// **'Mark as fasted'**
  String get markDayAsFasted;

  /// No description provided for @unmarkDayAsFasted.
  ///
  /// In en, this message translates to:
  /// **'Unmark as fasted'**
  String get unmarkDayAsFasted;

  /// No description provided for @selectDayPrompt.
  ///
  /// In en, this message translates to:
  /// **'Select a day to see details.'**
  String get selectDayPrompt;

  /// No description provided for @fastingTypeSpecialDays.
  ///
  /// In en, this message translates to:
  /// **'Special'**
  String get fastingTypeSpecialDays;

  /// No description provided for @legend.
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get legend;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @noMoreUpcomingDays.
  ///
  /// In en, this message translates to:
  /// **'No other upcoming fasts to display.'**
  String get noMoreUpcomingDays;

  /// No description provided for @aboutFastingTitle.
  ///
  /// In en, this message translates to:
  /// **'About Fasting'**
  String get aboutFastingTitle;

  /// No description provided for @aboutFastingContent.
  ///
  /// In en, this message translates to:
  /// **'Voluntary fasting outside of Ramadan is a recommended practice in Islam. It is a form of worship that brings numerous spiritual and physical benefits.'**
  String get aboutFastingContent;

  /// No description provided for @fastingBenefitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Benefits of Fasting'**
  String get fastingBenefitsTitle;

  /// No description provided for @benefitHealth.
  ///
  /// In en, this message translates to:
  /// **'Improves physical health, aids in detoxification of the body and can reduce inflammation.'**
  String get benefitHealth;

  /// No description provided for @benefitSpiritual.
  ///
  /// In en, this message translates to:
  /// **'Strengthens spiritual connection, develops patience and provides an opportunity for reflection.'**
  String get benefitSpiritual;

  /// No description provided for @benefitMental.
  ///
  /// In en, this message translates to:
  /// **'Improves concentration, promotes mental clarity and can reduce stress and anxiety.'**
  String get benefitMental;

  /// No description provided for @legendMondayThursday.
  ///
  /// In en, this message translates to:
  /// **'Monday/Thursday'**
  String get legendMondayThursday;

  /// No description provided for @legendWhiteDays.
  ///
  /// In en, this message translates to:
  /// **'White Days'**
  String get legendWhiteDays;

  /// No description provided for @legendSpecialDays.
  ///
  /// In en, this message translates to:
  /// **'Special Days'**
  String get legendSpecialDays;

  /// No description provided for @ramadan.
  ///
  /// In en, this message translates to:
  /// **'Ramadan'**
  String get ramadan;

  /// No description provided for @eidAlFitr.
  ///
  /// In en, this message translates to:
  /// **'Eid al-Fitr'**
  String get eidAlFitr;

  /// No description provided for @eidAlAdha.
  ///
  /// In en, this message translates to:
  /// **'Eid al-Adha'**
  String get eidAlAdha;

  /// No description provided for @tashriqDays.
  ///
  /// In en, this message translates to:
  /// **'Tashriq Days'**
  String get tashriqDays;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
