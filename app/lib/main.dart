import 'package:flutter/material.dart';
import 'package:itflowapp/controllers/firebase/auth.dart';
import 'package:itflowapp/controllers/firebase/database.dart';
import 'package:itflowapp/models/user.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/screens/all_screens.dart';
import 'package:flutter/services.dart';
import 'package:itflowapp/models/job.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:itflowapp/firebase_options.dart';

void main() async {
  // Firebase Initialization
  // WidgetsFlutterBinding.ensureInitialized(); called by runApp.
  final myApp = MyApp();
  runApp(myApp);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  myApp.initialize();

  // Portrait Mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatefulWidget {
  static GlobalKey mtAppKey = GlobalKey();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  MyApp({super.key});

  Future<dynamic> initialize() {
    print(AuthController.currentUser);
    final String initialRoute;
    if (AuthController.isLoggedIn) {
      DataBaseController.getUser(AuthController.currentUser!.uid)
          .then((info) {
        AuthController.currentUserModel = UserModel.fromFirestore(info!);
      });
      AuthController.rememberMe = true;
      initialRoute = Routes.home;
    } else {
      initialRoute = Routes.start;
    }
    return navigatorKey.currentState!.pushReplacementNamed(initialRoute);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() => { WidgetsBinding.instance.addObserver(this), super.initState() };

  @override
  void dispose() => { WidgetsBinding.instance.removeObserver(this), super.dispose() };

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("State: $state");
    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        if (!AuthController.isGuest) {
          AuthController.logoutIfNotRememberMe().then((loggedOut) {
            if (loggedOut) {
              widget.navigatorKey.currentState!.pushReplacementNamed(Routes.start);
            }
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: MyApp.mtAppKey,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      title: 'ItFlow App',
      navigatorKey: widget.navigatorKey,
      initialRoute: Routes.loading,
      routes: Routes.routes,
    );
  }
}

class Routes {
  static const String loading = '/loading';
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
    loading: (context) => const LoadingScreen(),
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
            final mtApp = MyApp.mtAppKey.currentWidget as MaterialApp;
            final routes = mtApp.routes;
            assert(routes!.containsKey(routeName));
            return routes![routeName]!(context);
          },
          transitionDuration: Duration.zero,
        );
}
