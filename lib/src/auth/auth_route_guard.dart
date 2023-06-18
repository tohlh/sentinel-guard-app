import 'package:flutter/material.dart';
import 'package:sentinel_guard_app/src/auth/auth_api_service.dart';

Widget routeGuard(Widget curr, Widget redirect) {
  Future loggedIn = AuthApiService.verifyToken();
  return FutureBuilder(
    future: loggedIn,
    builder: (context, snapshot) {
      if (snapshot.data == true) {
        return curr;
      } else {
        return redirect;
      }
    },
  );
}
