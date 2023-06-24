import 'package:flutter/material.dart';
import '../auth/auth_api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SentinelGuard User Login'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      AuthApiService.login(email.text, password.text).then(
                        (value) =>
                            Navigator.pushReplacementNamed(context, '/layout'),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login failed")));
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New user?'),
                    TextButton(
                      child: Text("Register"),
                      onPressed: () => {
                        // print("pressed!");
                        Navigator.pushReplacementNamed(context, '/register')
                      },
                    )
                  ],
                ),
              ),
              TextButton(
                child: Text("Bank Login"),
                onPressed: () => {
                  // print("pressed!")
                  Navigator.pushReplacementNamed(context, '/login_bank')
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
