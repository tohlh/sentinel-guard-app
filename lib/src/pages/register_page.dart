import 'package:flutter/material.dart';
import 'package:sentinel_guard_app/src/auth/auth_api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SentinelGuard User Register'),
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
                      await AuthApiService.register(name.text, email.text, password.text, cpassword.text).then((value) => Navigator.pushReplacementNamed(context, '/home'));
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
                      Navigator.pushReplacementNamed(context, '/login')
                    },)
                  ],
                ),
              ),
        
              TextButton(
                child: Text("Bank Register"),
                onPressed: () => {
                  print("pressed!")
                    // Navigator.pushReplacementNamed(context, '/bank_register')
                },
              )
            ],
            )
          ),
      ),
    );
  }
}