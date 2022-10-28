import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Subrate'**
  String get app_name;

  String get ok;

  String get selectImage;

  String get camera;

  String get gallery;
  String get kyc_valid;

  String get date_not_selected;
  String get uploadid;
  String get select;
  String get idtype;

  /// No description provided for @welcome_to.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcome_to;

  /// No description provided for @to_follow_please.
  ///
  /// In en, this message translates to:
  /// **'To follow please'**
  String get to_follow_please;

  /// No description provided for @password_length.
  ///
  /// In en, this message translates to:
  /// **'Password must not be less than 9 characters'**
  String get password_length;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @desc_log_in.
  ///
  /// In en, this message translates to:
  /// **'Log in, or create an account If you have an account'**
  String get desc_log_in;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @register_by_email.
  ///
  /// In en, this message translates to:
  /// **'Or register by e-mail'**
  String get register_by_email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get forget_password;

  /// No description provided for @register_with_google.
  ///
  /// In en, this message translates to:
  /// **'Register with Google'**
  String get register_with_google;

  /// No description provided for @register_with_facebook.
  ///
  /// In en, this message translates to:
  /// **'Register with Facebook'**
  String get register_with_facebook;

  /// No description provided for @do_not_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account ?'**
  String get do_not_have_an_account;

  /// No description provided for @enter_required_data.
  ///
  /// In en, this message translates to:
  /// **'Enter required data!'**
  String get enter_required_data;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter email!'**
  String get enter_email;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter password!'**
  String get enter_password;

  /// No description provided for @enter_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password !'**
  String get enter_confirm_password;

  /// No description provided for @enter_username.
  ///
  /// In en, this message translates to:
  /// **'Enter username !'**
  String get enter_username;

  /// No description provided for @enter_correct_email.
  ///
  /// In en, this message translates to:
  /// **'Enter correct email!'**
  String get enter_correct_email;

  /// No description provided for @enter_correct_password.
  ///
  /// In en, this message translates to:
  /// **'Enter correct password!'**
  String get enter_correct_password;

  /// No description provided for @login_successfully.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get login_successfully;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account ?'**
  String get already_have_an_account;

  /// No description provided for @two_password_are_not_equaled.
  ///
  /// In en, this message translates to:
  /// **'Two password are not equaled!'**
  String get two_password_are_not_equaled;

  /// No description provided for @sign_up_successfully.
  ///
  /// In en, this message translates to:
  /// **'sign up successfully'**
  String get sign_up_successfully;

  /// No description provided for @sign_up_failed.
  ///
  /// In en, this message translates to:
  /// **'sign up failed'**
  String get sign_up_failed;
  String get lesson;
  String get register_with_apple;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @need_help_with_password.
  ///
  /// In en, this message translates to:
  /// **'Need help with password?'**
  String get need_help_with_password;

  /// No description provided for @you_can_retrieve_your_password.
  ///
  /// In en, this message translates to:
  /// **'You can retrieve your password by entering your email in the text box below'**
  String get you_can_retrieve_your_password;

  /// No description provided for @put_your_email_here.
  ///
  /// In en, this message translates to:
  /// **'Put your email here'**
  String get put_your_email_here;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'SEND'**
  String get send;

  /// No description provided for @password_reset_email_sent.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Email Sent'**
  String get password_reset_email_sent;

  /// No description provided for @qr_code.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qr_code;

  /// No description provided for @logout_failed.
  ///
  /// In en, this message translates to:
  /// **'Logout Failed'**
  String get logout_failed;

  /// No description provided for @scan_code.
  ///
  /// In en, this message translates to:
  /// **'Scan The Code'**
  String get scan_code;

  /// No description provided for @scan_code_on_card.
  ///
  /// In en, this message translates to:
  /// **'You must scan the code on the card tray to be able to use the features of the application'**
  String get scan_code_on_card;

  /// No description provided for @verify_email.
  ///
  /// In en, this message translates to:
  /// **'Verify email to login into the app!'**
  String get verify_email;

  /// No description provided for @network_request_failed.
  ///
  /// In en, this message translates to:
  /// **'Network Request Failed'**
  String get network_request_failed;

  /// No description provided for @user_disabled.
  ///
  /// In en, this message translates to:
  /// **'User Disabled'**
  String get user_disabled;

  /// No description provided for @user_not_found.
  ///
  /// In en, this message translates to:
  /// **'User Not Found'**
  String get user_not_found;

  /// No description provided for @wrong_password.
  ///
  /// In en, this message translates to:
  /// **'Wrong Password'**
  String get wrong_password;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get invalid_email;

  /// No description provided for @unknown_error.
  ///
  /// In en, this message translates to:
  /// **'Something Error!'**
  String get unknown_error;

  /// No description provided for @email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'The email address is already in use by another account.'**
  String get email_already_in_use;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @old_password.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get old_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirm_new_password;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @enter_old_password.
  ///
  /// In en, this message translates to:
  /// **'Enter old password!'**
  String get enter_old_password;

  /// No description provided for @enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter new password!'**
  String get enter_new_password;

  /// No description provided for @enter_confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm new password!'**
  String get enter_confirm_new_password;

  /// No description provided for @wrong_old_password.
  ///
  /// In en, this message translates to:
  /// **'Wrong old password!'**
  String get wrong_old_password;

  /// No description provided for @enter_correct_old_password.
  ///
  /// In en, this message translates to:
  /// **'Enter correct old password!'**
  String get enter_correct_old_password;

  /// No description provided for @enter_correct_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter correct new password!'**
  String get enter_correct_new_password;

  /// No description provided for @two_password_not_equaled.
  ///
  /// In en, this message translates to:
  /// **'Two password are not equaled!'**
  String get two_password_not_equaled;

  /// No description provided for @enter_correct_confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter correct confirm new password!'**
  String get enter_correct_confirm_new_password;

  /// No description provided for @change_password_successfully.
  ///
  /// In en, this message translates to:
  /// **'Change password Successfully'**
  String get change_password_successfully;

  /// No description provided for @change_password_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed Change Password'**
  String get change_password_failed;

  /// No description provided for @logout_successfully.
  ///
  /// In en, this message translates to:
  /// **'Logout Successfully'**
  String get logout_successfully;

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed, try again'**
  String get login_failed;

  /// No description provided for @english_letters.
  ///
  /// In en, this message translates to:
  /// **'English letters'**
  String get english_letters;

  /// No description provided for @arabic_letters.
  ///
  /// In en, this message translates to:
  /// **'Arabic letters'**
  String get arabic_letters;

  /// No description provided for @numbers.
  ///
  /// In en, this message translates to:
  /// **'Numbers'**
  String get numbers;

  /// No description provided for @animals.
  ///
  /// In en, this message translates to:
  /// **'Animals'**
  String get animals;

  /// No description provided for @shapes.
  ///
  /// In en, this message translates to:
  /// **'Shapes'**
  String get shapes;

  /// No description provided for @birds.
  ///
  /// In en, this message translates to:
  /// **'Birds'**
  String get birds;

  /// No description provided for @vegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get vegetables;

  /// No description provided for @fruits.
  ///
  /// In en, this message translates to:
  /// **'Fruits'**
  String get fruits;

  /// No description provided for @colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors;

  /// No description provided for @numbers_game.
  ///
  /// In en, this message translates to:
  /// **'Numbers Game'**
  String get numbers_game;

  /// No description provided for @words_game.
  ///
  /// In en, this message translates to:
  /// **'Words Game'**
  String get words_game;

  /// No description provided for @profile_personally.
  ///
  /// In en, this message translates to:
  /// **'Profile Personal'**
  String get profile_personally;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'BirthDate'**
  String get birthDate;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number!'**
  String get enter_phone_number;

  /// No description provided for @enter_address.
  ///
  /// In en, this message translates to:
  /// **'Enter Address!'**
  String get enter_address;

  /// No description provided for @enter_gender.
  ///
  /// In en, this message translates to:
  /// **'Enter Gender!'**
  String get enter_gender;

  /// No description provided for @gender_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get gender_male;

  /// No description provided for @gender_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get gender_female;

  /// No description provided for @select_gender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get select_gender;

  /// No description provided for @enter_birthdate.
  ///
  /// In en, this message translates to:
  /// **'Enter BirthDate!'**
  String get enter_birthdate;

  /// No description provided for @image_uploaded_successfully.
  ///
  /// In en, this message translates to:
  /// **'The image has been uploaded successfully'**
  String get image_uploaded_successfully;

  /// No description provided for @image_uploaded_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload image'**
  String get image_uploaded_failed;

  /// No description provided for @profile_update_succeeded.
  ///
  /// In en, this message translates to:
  /// **'Profile update succeeded'**
  String get profile_update_succeeded;

  /// No description provided for @profile_update_failed.
  ///
  /// In en, this message translates to:
  /// **'Update Profile Failed'**
  String get profile_update_failed;

  /// No description provided for @not_have_connection.
  ///
  /// In en, this message translates to:
  /// **'You do not have an internet connection'**
  String get not_have_connection;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @start_now.
  ///
  /// In en, this message translates to:
  /// **'START NOW'**
  String get start_now;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skip;

  /// No description provided for @interactive_self_learning.
  ///
  /// In en, this message translates to:
  /// **'interactive self learning'**
  String get interactive_self_learning;

  /// No description provided for @desc_on_boarding_one.
  ///
  /// In en, this message translates to:
  /// **'This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator'**
  String get desc_on_boarding_one;

  /// No description provided for @machine_learning_based_education.
  ///
  /// In en, this message translates to:
  /// **'Machine learning based education'**
  String get machine_learning_based_education;

  /// No description provided for @explore_the_alphabet_and_more.
  ///
  /// In en, this message translates to:
  /// **'Explore the alphabet and more'**
  String get explore_the_alphabet_and_more;

  /// No description provided for @demonstration_video.
  ///
  /// In en, this message translates to:
  /// **'Demonstration Video'**
  String get demonstration_video;

  /// No description provided for @learn_how_to_play.
  ///
  /// In en, this message translates to:
  /// **'Learn how to play'**
  String get learn_how_to_play;

  /// No description provided for @demonstration_video_desc.
  ///
  /// In en, this message translates to:
  /// **'This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator, where you can generate such text'**
  String get demonstration_video_desc;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @lang.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get lang;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @voice.
  ///
  /// In en, this message translates to:
  /// **'Voice'**
  String get voice;

  /// No description provided for @about_app.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get about_app;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @about_app_desc.
  ///
  /// In en, this message translates to:
  /// **'This text is an example of a text that can be replaced in the same space. This text was generated from the Arabic text generator, where you can generate such text or many other texts in addition to increasing the number of characters generated by the application.\nIf you need more paragraphs, the Arabic text generator allows you to increase the number of paragraphs as you want, the text will not appear divided and does not contain language errors, the Arabic text generator is useful for web designers in particular, where the customer often needs to see a real picture for site design.\nHence, the designer must put temporary texts on the design to show the client the complete form. The role of the Arabic text generator is to save the designer the trouble of searching for an alternative text that has nothing to do with the topic that the design is talking about, so it appears in an inappropriate manner.'**
  String get about_app_desc;

  /// No description provided for @how_to_use_the_app.
  ///
  /// In en, this message translates to:
  /// **'How to use the app'**
  String get how_to_use_the_app;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @mission.
  ///
  /// In en, this message translates to:
  /// **'missions'**
  String get mission;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'profile'**
  String get profile;

  /// No description provided for @wallet_desc.
  ///
  /// In en, this message translates to:
  /// **'Go to your wallet to see in detail your transactions within the application'**
  String get wallet_desc;

  /// No description provided for @total_earnings.
  ///
  /// In en, this message translates to:
  /// **'Total Earnings'**
  String get total_earnings;

  /// No description provided for @total_coins.
  ///
  /// In en, this message translates to:
  /// **'Total Coins'**
  String get total_coins;

  /// No description provided for @coins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coins;

  /// No description provided for @gifts.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get gifts;

  /// No description provided for @overall_achievement.
  ///
  /// In en, this message translates to:
  /// **'Overall Achievement'**
  String get overall_achievement;

  /// No description provided for @remaining_missions.
  ///
  /// In en, this message translates to:
  /// **'Remaining Missions'**
  String get remaining_missions;

  /// No description provided for @today_missions.
  ///
  /// In en, this message translates to:
  /// **'Today Missions'**
  String get today_missions;

  /// No description provided for @no_has_title.
  ///
  /// In en, this message translates to:
  /// **'No has title'**
  String get no_has_title;

  /// No description provided for @no_has_description.
  ///
  /// In en, this message translates to:
  /// **'No has description'**
  String get no_has_description;

  /// No description provided for @application_language.
  ///
  /// In en, this message translates to:
  /// **'Application language'**
  String get application_language;

  /// No description provided for @profile_information.
  ///
  /// In en, this message translates to:
  /// **'Profile information'**
  String get profile_information;

  /// No description provided for @password_change.
  ///
  /// In en, this message translates to:
  /// **'Password change'**
  String get password_change;

  /// No description provided for @confirm_logout.
  ///
  /// In en, this message translates to:
  /// **'Do you want to confirm logout?'**
  String get confirm_logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @general_knowledge.
  ///
  /// In en, this message translates to:
  /// **'General Knowledge'**
  String get general_knowledge;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @todo.
  ///
  /// In en, this message translates to:
  /// **'ToDo'**
  String get todo;

  /// No description provided for @success_do_mission.
  ///
  /// In en, this message translates to:
  /// **'Success do mission'**
  String get success_do_mission;

  /// No description provided for @failed_do_mission.
  ///
  /// In en, this message translates to:
  /// **'Failed do mission'**
  String get failed_do_mission;

  /// No description provided for @no_internet_connection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get no_internet_connection;

  /// No description provided for @total_points.
  ///
  /// In en, this message translates to:
  /// **'Total Points'**
  String get total_points;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @go_wallet.
  ///
  /// In en, this message translates to:
  /// **'Go Wallet'**
  String get go_wallet;

  /// No description provided for @statements.
  ///
  /// In en, this message translates to:
  /// **'Statements'**
  String get statements;

  /// No description provided for @go.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get go;

  /// No description provided for @ranking.
  ///
  /// In en, this message translates to:
  /// **'Ranking'**
  String get ranking;

  /// No description provided for @your_rank.
  ///
  /// In en, this message translates to:
  /// **'Your Rank'**
  String get your_rank;

  /// No description provided for @password_changed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get password_changed_successfully;

  /// No description provided for @password_changed_failed.
  ///
  /// In en, this message translates to:
  /// **'Password change failed'**
  String get password_changed_failed;

  /// No description provided for @select_option.
  ///
  /// In en, this message translates to:
  /// **'Select Your Payout Option'**
  String get select_option;
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
