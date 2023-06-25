import 'package:flutter/material.dart';
import 'package:sentinel_guard_app/src/auth/auth_api_service.dart';
import 'package:sentinel_guard_app/src/models/user.dart';
import 'package:sentinel_guard_app/src/api/user_api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft,
        //       colors: [
        //         Colors.blue,
        //         Colors.red,
        //       ],
        //     )
        //   ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder<User>(
                  future: futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Icon(Icons.account_circle, size: 80, 
                          // color: Colors.white,
                          ),
                          SizedBox(
                            height: 20, // <-- SEE HERE
                          ),
                          Text(snapshot.data!.name,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                          ),
                          Text(snapshot.data!.email, 
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),)
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: 250, 
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      await AuthApiService.logout().then((value) =>
                          Navigator.pushReplacementNamed(context, '/login'));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Something went wrong!")));
                    }
                  },
                  
                  child: Container(
                  
                  height: 60,
                  // width: 200,
                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                  colors: [
                    // Color.fromRGBO(255, 143, 158, 1),
                    // Color.fromRGBO(255, 188, 143, 1),
                    Colors.blue,
                    Colors.purple
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                              ),
                              borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                              ),
                              boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                              ]
                            ),
                            child: Center(
                              child: GestureDetector(
                  onTap: () {
                    // print("tapped");
                  },
                  child: const Text(
                    'Logout',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      // fontFamily: "Netflix",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                  ),
                              ),
                            ),
                          ),
                ),
                // ElevatedButton(
                //   // style: ButtonStyle(padding: ),
                  // onPressed: () async {
                  //   try {
                  //     await AuthApiService.logout().then((value) =>
                  //         Navigator.pushReplacementNamed(context, '/login'));
                  //   } catch (e) {
                  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //         content: Text("Something went wrong!")));
                  //   }
                  // },
                //   child: const Text('Logout'),
                // ),
              ],
            ),
          ),
      ),
    );
  }
}
