import 'package:flutter/material.dart';

import '../views/app/edit_profile_screen.dart';
import '../views/app/home_screen.dart';
import '../views/app/settings/app_lang_screen.dart';
import '../views/app/wallet/done_screen.dart';
import '../views/app/wallet/rank_screen.dart';
import '../views/app/wallet/statements_screen.dart';
import '../views/app/wallet/wallet_screen.dart';
import '../views/auth/authentication_screen.dart';
import '../views/auth/change_password_screen.dart';
import '../views/auth/forgot_password_screen.dart';
import '../views/auth/sign_in_screen.dart';
import '../views/auth/sign_up_screen.dart';
import '../views/launch_screen.dart';

class MaterialAppRoutes {
  static Map<String, WidgetBuilder> routes() {
    return {
      '/launch_screen': (context) => const LaunchScreen(),
      '/authentication_screen': (context) => const AuthenticationScreen(),
      '/sign_in_screen': (context) => const SignInScreen(),
      '/sign_up_screen': (context) => const SignUpScreen(),
      '/forgot_password_screen': (context) => const ForgotPasswordScreen(),
      '/home_screen': (context) => const HomeScreen(),
      '/edit_profile_screen': (context) => const EditProfileScreen(),
      '/change_password_screen': (context) => const ChangePasswordScreen(),
      '/wallet_screen': (context) => const WalletScreen(),
      '/statements_screen': (context) => const StatementsScreen(),
      '/rank_screen': (context) => const RankScreen(),
      '/done_screen': (context) => const DoneScreen(),
      '/app_lang_screen': (context) => const AppLangScreen(),
      // '/kyc_screen': (context) => const KycScreen(),
    };
  }
}
