import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/material.dart';
import 'package:sentinel_guard_app/src/crypto_service.dart';
import 'package:sentinel_guard_app/src/models/bank.dart';
import 'package:sentinel_guard_app/src/models/message.dart';
import 'package:sentinel_guard_app/src/api/user_api_service.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';

class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({Key? key}) : super(key: key);

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final Bank currentBank = ModalRoute.of(context)!.settings.arguments as Bank;
    print("currentBank");
    print(currentBank.bankCommunicationKey);
    Future<List<Message>> futureMessages =
        UserApiService.getMessages(currentBank.bankCommunicationKey);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentBank.name),
        flexibleSpace: GestureDetector(
          onTap: () {
            print("tapped");
          },
        ),
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text('User Communication Key'),
                Text(currentBank.userCommunicationKey),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(100),
            child: TextButton(
              // onPressed: () {
              //   print("hi");
              // },
              onPressed: (){
                print("delete button");
                try {
                UserApiService.deleteBank(currentBank.bankCommunicationKey);
                } catch (err) {
                  print(err);
                }
                // Navigator.pop(context);
                Navigator.pushNamed(context, '/layout');
              }, 
              child: const Text("Delete Bank"),
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(20),
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
              ),
            ),
          ),
        ],
      )
    );
  }
}
