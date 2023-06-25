import 'package:doctive_sympthon_checker/constants/colors.dart';
import 'package:doctive_sympthon_checker/pages/conversation_list_screen.dart';
import 'package:doctive_sympthon_checker/pages/conversation_screen.dart';
import 'package:doctive_sympthon_checker/pages/dashboard_screen.dart';
import 'package:doctive_sympthon_checker/pages/edit_presonal_information_screen.dart';
import 'package:doctive_sympthon_checker/pages/edit_profile_screen.dart';
import 'package:doctive_sympthon_checker/pages/email_verification_screen.dart';
import 'package:doctive_sympthon_checker/pages/home_sceen.dart';
import 'package:doctive_sympthon_checker/pages/login_screen.dart';
import 'package:doctive_sympthon_checker/pages/onboarding_screen.dart';
import 'package:doctive_sympthon_checker/pages/profile_screen.dart';
import 'package:doctive_sympthon_checker/pages/restore_account_screen.dart';
import 'package:doctive_sympthon_checker/pages/settings_screen.dart';
import 'package:doctive_sympthon_checker/pages/show_recovery_phrase.dart';
import 'package:doctive_sympthon_checker/pages/splash_screen.dart';
import 'package:doctive_sympthon_checker/pages/start_conversation_screen.dart';
import 'package:doctive_sympthon_checker/services/api_service.dart';
import 'package:doctive_sympthon_checker/services/crypto_service.dart';
import 'package:doctive_sympthon_checker/services/local_auth_service.dart';
import 'package:doctive_sympthon_checker/services/secret_service.dart';
import 'package:doctive_sympthon_checker/services/user_service.dart';
import 'package:doctive_sympthon_checker/services/utils_service.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

GetIt resolver = GetIt.instance;

//
// Setting up DI
//
void setup() {
  resolver.registerSingleton<UtilsService>(UtilsService());
  resolver.registerSingleton<SecretService>(SecretService());
  resolver.registerSingleton<CryptoService>(CryptoService());
  resolver.registerSingleton<LocalAuthService>(LocalAuthService());
  resolver.registerLazySingleton<ApiService>(
      () => ApiService('http', '10.0.2.2:3000'));
  resolver.registerLazySingleton<UserService>(() => UserService());
}

//
// Configure basic settings for the whole application
//
void configure() {
  Intl.defaultLocale = 'de_DE';
}

void main() {
  setup();
  configure();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctive',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: AppColors.primaryColor,
        // errorColor: ,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        HomeScreen.route: (context) => HomeScreen(),
        OnBoardingScreen.route: (context) => OnBoardingScreen(),
        DashboardScreen.route: (context) => DashboardScreen(),
        LoginScreen.route: (context) => LoginScreen(),
        RestoreAccountScreen.route: (context) => RestoreAccountScreen(),
        ProfileScreen.route: (context) => ProfileScreen(),
        EditProfileScreen.route: (context) => EditProfileScreen(),
        EditPersonalInformationScreen.route: (context) => EditPersonalInformationScreen(),
        EmailVerificationScreen.route: (context) => EmailVerificationScreen(),
        ConversationListScreen.route: (context) => ConversationListScreen(),
        ConversationScreen.route: (context) => ConversationScreen(),
        SettingsScreen.route: (context) => SettingsScreen(),
        ShowRecoveryPhrase.route: (context) => ShowRecoveryPhrase(),
        StartConversation.route:(context) => StartConversation(),
      },
    );
  }
}
