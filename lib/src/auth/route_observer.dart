import 'package:flutter/material.dart';

class AuthRouteObserver extends RouteObserver<PageRoute> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != '/login') {
      // Check if the JWT token exists
      bool tokenExists = true;

      if (!tokenExists) {
        // Redirect to the login page
        Navigator.of(route.navigator!.context).pushReplacementNamed('/login');
      }
    }
  }
}
