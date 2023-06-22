import 'package:flutter/material.dart';
import 'package:sentinel_guard_app/src/models/user.dart';
import 'package:sentinel_guard_app/src/api/user_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    // const Duration(seconds: 2);
    futureUser = UserApiService.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: Scaffold(
          body: Center(
            child: FutureBuilder<User>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.name);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
