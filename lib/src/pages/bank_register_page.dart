import 'package:flutter/material.dart';
import 'package:sentinel_guard_app/src/auth/auth_api_service.dart';

class BankRegisterPage extends StatefulWidget {
  const BankRegisterPage({super.key});

  @override
  State<BankRegisterPage> createState() => _BankRegisterPageState();
}

class _BankRegisterPageState extends State<BankRegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SentinelGuard Bank Register'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
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
              TextFormField(
                controller: cpassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value != password.text) {
                    print(value);
                    return 'Password does not match';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await AuthApiService.registerBank(name.text, username.text, password.text, cpassword.text).then((value) => Navigator.pushReplacementNamed(context, '/home'));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Register failed"))
                      );
                    }
                  }, 
                  child: const Text('Register'),
                  ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Have an account?'),
                    TextButton(child: Text("Login"),
                    onPressed: () => {
                      // print("pressed!");
                      Navigator.pushReplacementNamed(context, '/login_bank')
                    },)
                  ],
                ),
              ),
        
              TextButton(
                child: Text("User Register"),
                onPressed: () => {
                  // print("pressed!")
                    Navigator.pushReplacementNamed(context, '/login')
                },
              )
            ],
            )
          ),
      ),
    );
  }
}