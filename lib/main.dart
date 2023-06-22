import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentinel_guard_app/src/auth/auth_route_guard.dart';
import 'package:sentinel_guard_app/src/pages/layout.dart';
import 'src/pages/login_page.dart';
import 'src/pages/register_page.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SentinelGuard',
      initialRoute: '/layout',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/layout': (context) => routeGuard(const Layout(), const LoginPage()),
        // '/login_bank': (context) => const BankLoginPage(),
        // '/register_bank': (context) => const BankRegisterPage(),
      },
    );
  }
}
