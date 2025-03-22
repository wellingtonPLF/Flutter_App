import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/app/config/local_database/persistent_storage.dart';
import 'package:my_app/app/config/theme/theme.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/shared/services/auth_service.dart';
import 'package:my_app/app/shared/services/jwt_service.dart';
import 'package:my_app/app/shared/services/user_service.dart';
import 'package:my_app/app/widgets/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await setupLocators();

  var storage = PersistentStorage();
  await storage.db;

  runApp(const MyApp());
}

Future<void> setupLocators() async {
  GetIt.I.registerSingleton(AuthController());
  // ******************************************************************
  GetIt.I.registerSingleton(AuthService());
  GetIt.I.registerSingleton(JwtService());
  GetIt.I.registerSingleton(UserService());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Application',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        navigatorKey: navigatorKey,
        home: const SplashscreenPage());
  }
}
