import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/material.dart';
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
    Future<List<Message>> futureMessages =
        UserApiService.getMessages(currentBank.bankCommunicationKey);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentBank.name),
      ),
      body: Center(
        child: FutureBuilder<List<Message>>(
          future: futureMessages,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return MessageListItem(message: snapshot.data![index]);
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
  const MessageListItem({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateChip(
          date: DateTime.parse(message.createdAt),
          color: const Color(0x558AD3D5),
        ),
        BubbleSpecialThree(
          text: message.content,
          color: const Color(0xFF1B97F3),
          tail: true,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
          isSender: false,
        )
      ],
    );
  }
}
