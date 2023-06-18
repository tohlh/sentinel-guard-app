import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/pages/home_page.dart';
import 'src/pages/login_page.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SentinelGuard',
      initialRoute: '/home',
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
