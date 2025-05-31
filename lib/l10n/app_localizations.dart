import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello Aboud'**
  String get homeGreeting;

  /// No description provided for @homeContinueLearning.
  ///
  /// In en, this message translates to:
  /// **'Continue learning, you\'re makeing your future'**
  String get homeContinueLearning;

  /// No description provided for @homeLatestNewsAndEvents.
  ///
  /// In en, this message translates to:
  /// **'Latest News and Events'**
  String get homeLatestNewsAndEvents;

  /// No description provided for @homeNoNewsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No news available'**
  String get homeNoNewsAvailable;

  /// No description provided for @homeAnotherNewsItem.
  ///
  /// In en, this message translates to:
  /// **'Another News Item'**
  String get homeAnotherNewsItem;

  /// No description provided for @homeNewsDescription.
  ///
  /// In en, this message translates to:
  /// **'Description for the second news item goes here.'**
  String get homeNewsDescription;

  /// No description provided for @homeThirdEvent.
  ///
  /// In en, this message translates to:
  /// **'Third Event'**
  String get homeThirdEvent;

  /// No description provided for @homeThirdEventDetails.
  ///
  /// In en, this message translates to:
  /// **'Details about the third event happening soon.'**
  String get homeThirdEventDetails;

  /// No description provided for @homeTodayTasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Tasks'**
  String get homeTodayTasks;

  /// No description provided for @homeStartNewChallenge.
  ///
  /// In en, this message translates to:
  /// **'Start a new challenge today'**
  String get homeStartNewChallenge;

  /// No description provided for @homeNoTasksForToday.
  ///
  /// In en, this message translates to:
  /// **'No tasks for today!'**
  String get homeNoTasksForToday;

  /// No description provided for @homeReviewChapterOne.
  ///
  /// In en, this message translates to:
  /// **'Review Chapter 1'**
  String get homeReviewChapterOne;

  /// No description provided for @homeSolveMathHomework.
  ///
  /// In en, this message translates to:
  /// **'Solve Math homework'**
  String get homeSolveMathHomework;

  /// No description provided for @homeContinueStudying.
  ///
  /// In en, this message translates to:
  /// **'Continue Studying'**
  String get homeContinueStudying;

  /// No description provided for @homeRecentlyAdded.
  ///
  /// In en, this message translates to:
  /// **'Recently Added'**
  String get homeRecentlyAdded;

  /// No description provided for @homeAdvancedSoftwareEngineering.
  ///
  /// In en, this message translates to:
  /// **'Advanced Software Engineering - Chapter 3'**
  String get homeAdvancedSoftwareEngineering;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCourses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get navCourses;

  /// No description provided for @navCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get navCommunity;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @todoMyToDos.
  ///
  /// In en, this message translates to:
  /// **'My ToDos'**
  String get todoMyToDos;

  /// No description provided for @todoEditTask.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get todoEditTask;

  /// No description provided for @todoAddNewTask.
  ///
  /// In en, this message translates to:
  /// **'Add New Task'**
  String get todoAddNewTask;

  /// Text shown when there are no tasks
  ///
  /// In en, this message translates to:
  /// **'No Tasks Yet'**
  String get todoNoTasks;

  /// Instruction for adding first task
  ///
  /// In en, this message translates to:
  /// **'Add your first task by tapping the + button below'**
  String get todoAddFirstTask;

  /// Label for setting due date
  ///
  /// In en, this message translates to:
  /// **'Set Due Date (Optional)'**
  String get todoSetDueDate;

  /// Due date with formatted date
  ///
  /// In en, this message translates to:
  /// **'Due: {date}'**
  String todoDueDate(String date);

  /// Button text for updating a task
  ///
  /// In en, this message translates to:
  /// **'Update Task'**
  String get todoUpdateTask;

  /// Button text for adding a task
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get todoAddTask;

  /// Label for completion checkbox
  ///
  /// In en, this message translates to:
  /// **'Mark as completed'**
  String get todoMarkAsCompleted;

  /// Text shown when loading tasks
  ///
  /// In en, this message translates to:
  /// **'Loading tasks...'**
  String get todoLoadingTasks;

  /// Text shown when no data is available
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get todoNoDataAvailable;

  /// Text shown when there are no news
  ///
  /// In en, this message translates to:
  /// **'No news available'**
  String get newsNoNewsAvailable;

  /// Message to check back later for news updates
  ///
  /// In en, this message translates to:
  /// **'Check back later for updates'**
  String get newsCheckBackLater;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Label for task title field
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get todoTitle;

  /// Validation message for empty title
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get todoEnterTitle;

  /// Label for task description field
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get todoDescription;

  /// Label for task importance section
  ///
  /// In en, this message translates to:
  /// **'Importance'**
  String get todoImportance;

  /// Label for low importance option
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get todoImportanceLow;

  /// Label for medium importance option
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get todoImportanceMedium;

  /// Label for high importance option
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get todoImportanceHigh;

  /// Text shown when no due date is set
  ///
  /// In en, this message translates to:
  /// **'No due date'**
  String get todoNoDueDate;

  /// Title for delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get todoConfirmDelete;

  /// Message for delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get todoDeleteConfirmation;

  /// Label for cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get todoCancel;

  /// Label for delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get todoDelete;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
