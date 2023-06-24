import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/material.dart';
import 'package:sentinel_guard_app/src/crypto_service.dart';
import 'package:sentinel_guard_app/src/models/bank.dart';
import 'package:sentinel_guard_app/src/models/message.dart';
import 'package:sentinel_guard_app/src/api/user_api_service.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';

class BankPage extends StatefulWidget {
  const BankPage({Key? key}) : super(key: key);

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
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
        actions: [
        IconButton(
          onPressed: () {
            print("tapped button");
          Navigator.pushNamed(context, '/bank_details', arguments: currentBank);
          },
          icon: Icon(Icons.more_horiz),
          padding: EdgeInsets.all(10),
        ),
      ],
      ),
      body: Center(
        child: FutureBuilder<List<Message>>(
          future: futureMessages,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return MessageListItem(
                    message: snapshot.data![index],
                    bank: currentBank,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Text('No messages yet');
          },
        ),
      ),
    );
  }
}

class MessageListItem extends StatelessWidget {
  const MessageListItem({Key? key, required this.message, required this.bank})
      : super(key: key);
  final Message message;
  final Bank bank;

  @override
  Widget build(BuildContext context) {
    Future<String> futureMessage =
        CryptoService.decryptMessage(message, bank.publicKey);
    return Center(
      child: FutureBuilder<String>(
        future: futureMessage,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Column(
              children: [
                DateChip(
                  date: DateTime.parse(message.createdAt),
                  color: const Color(0x558AD3D5),
                ),
                BubbleSpecialThree(
                  text: snapshot.data!,
                  color: const Color(0xFF1B97F3),
                  tail: true,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                  isSender: false,
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Text('No messages yet');
        },
      ),
    );
  }
}
