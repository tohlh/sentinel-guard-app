import 'package:flutter/material.dart';
import '../auth/auth_api_service.dart';

class BankLoginPage extends StatefulWidget {
  const BankLoginPage({Key? key}) : super(key: key);

  @override
  State<BankLoginPage> createState() => _BankLoginPageState();
}

class _BankLoginPageState extends State<BankLoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SentinelGuard Bank Login'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
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
                      await AuthApiService.loginBank(username.text, password.text).then(
                          (value) =>
                              Navigator.pushReplacementNamed(context, '/home'));
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
                    const Text('New bank?'),
                    TextButton(child: Text("Register"),
                    onPressed: () => {
                      // print("pressed!");
                      Navigator.pushReplacementNamed(context, '/register_bank')
                    },)
                  ],
                ),
              ),
              TextButton(
                child: Text("User Login"),
                onPressed: () => {
                  // print("pressed!")
                    Navigator.pushReplacementNamed(context, '/login')
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
