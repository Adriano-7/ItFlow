import 'package:flutter/material.dart';
import 'package:itflowapp/controllers/auth.dart';
import 'package:itflowapp/controllers/database.dart';
import 'package:itflowapp/models/user.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/screens/all_screens.dart';
import 'package:flutter/services.dart';
import 'package:itflowapp/models/job.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/constants.dart';
import 'firebase_options.dart';

void main() {
  // Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) {
    SharedPreferences.getInstance().then((prefs) {
      final bool? rememberMe = prefs.getBool(kRememberMePrefName);
      if (rememberMe == null || !rememberMe){
        AuthController.logout();
        runApp(const MyApp(initialRoute: Routes.start));
      } else {
        DataBaseController.getUser(AuthController.currentUser!.uid).then((info) {
          AuthController.currentUserModel = UserModel.fromFirestore(info!);
        });
        runApp(const MyApp(initialRoute: Routes.home));
      }
    });
  });

  // Portrait Mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, this.initialRoute = Routes.start});

  static GlobalKey mtAppKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: MyApp.mtAppKey,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      title: 'ItFlow App',
      initialRoute: initialRoute,
      routes: Routes.routes,
    );
  }
}

class Routes {
  static const String start = '/start';
  static const String login = '/start/login';
  static const String register = '/start/register';
  static const String home = '/home';
  static const String search = '/search';
  static const String notification = '/notification';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String jobDetails = '/jobDetails';
  static Map<String, Widget Function(BuildContext)> routes = {
    start: (context) => const StartScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => RegisterScreen(),
    home: (context) => const HomeScreen(),
    search: (context) => const SearchScreen(),
    notification: (context) => const NotificationScreen(),
    profile: (context) => const ProfileScreen(),
    settings: (context) => const SettingsScreen(),
    jobDetails: (context) => JobDetailsScreen(
          jobOffer: ModalRoute.of(context)!.settings.arguments as Job,
        ),
  };
}

class NoPageTransitionToMyApp extends PageRouteBuilder {
  NoPageTransitionToMyApp(
    String routeName, {
    Object? arguments,
  }) : super(
          settings: RouteSettings(
            arguments: arguments,
            name: routeName,
          ),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            assert(MyApp.mtAppKey.currentWidget != null);
            assert(MyApp.mtAppKey.currentWidget is MaterialApp);
            var mtapp = MyApp.mtAppKey.currentWidget as MaterialApp;
            var routes = mtapp.routes;
            assert(routes!.containsKey(routeName));
            return routes![routeName]!(context);
          },
          transitionDuration: Duration.zero,
        );
}