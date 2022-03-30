import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_starter_project/screens/bottombar/bottombar_screen.dart';
import 'package:flutter_starter_project/screens/login/login_screen.dart';
import 'package:flutter_starter_project/screens/splash/splash_screen.dart';

final baseUrlProvider = Provider((ref) => "https://reqres.in/api");

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await Firebase.initializeApp();
  // await PushNotificationService.instance.init();

  final container = ProviderContainer();
  final routerDelegate = createDelegate(container.read);
  final routeInformationParser = BeamerParser();

  runApp(
      UncontrolledProviderScope(
        container: container,
        child: MyApp(routeInformationParser, routerDelegate),
      ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp(this.routeInformationParser, this.routerDelegate);

  final RouteInformationParser<Object> routeInformationParser;
  final RouterDelegate<Object> routerDelegate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate
    );
  }
}

BeamerDelegate createDelegate(Reader read) => BeamerDelegate(
  initialPath: '/splash',
  clearBeamingHistoryOn: { '/login', '/bottombar' },
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/splash': (context, state, data) => const SplashScreen(),
      '/login': (context, state, data) => const LoginScreen(),
      '/bottombar': (context, state, data) => const BottombarScreen(),
    },
  ),
  guards: [
    BeamGuard(
      pathPatterns: ['/login'],
      guardNonMatching: true,
      check: (context, location) {
        return true;
      },
      beamToNamed: (origin, target) => '/login',
    ),
    BeamGuard(
      pathPatterns: ['/login'],
      guardNonMatching: false,
      check: (context, location) {
        return true;
      },
      beamToNamed: (origin, target) => '/bottombar',
    )
  ],
);