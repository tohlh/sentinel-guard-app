import 'package:flutter/material.dart';
import 'package:sentinel_guard_app/src/models/bank.dart';
import 'package:sentinel_guard_app/src/api/user_api_service.dart';

class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({Key? key}) : super(key: key);

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final Bank currentBank = ModalRoute.of(context)!.settings.arguments as Bank;
    return Scaffold(
      appBar: AppBar(
        title: Text(currentBank.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  "Bank communication ID",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(currentBank.bankCommunicationKey),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Your communication ID",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "(Provide this to your bank to link your account)",
                  style: TextStyle(fontSize: 14),
                ),
                Text(currentBank.userCommunicationKey),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(100),
            child: TextButton(
              onPressed: () {
                UserApiService.deleteBank(currentBank.bankCommunicationKey)
                    .then((value) =>
                        Navigator.pushReplacementNamed(context, '/layout'));
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
              child: const Text("Delete Bank"),
            ),
          ),
        ],
      ),
    );
  }
}
