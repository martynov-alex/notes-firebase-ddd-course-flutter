import 'package:auto_route/auto_route.dart';
import 'package:notes_firebase_ddd_course/presentation/sign_in/sign_in_page.dart';
import 'package:notes_firebase_ddd_course/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: SplashPage, initial: true),
    AutoRoute<dynamic>(page: SignInPage),
  ],
)
class $AppRouter {}
