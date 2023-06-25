import 'package:flutter/material.dart';
import 'package:sentinel_guard_app/src/crypto_service.dart';
import 'package:sentinel_guard_app/src/models/bank.dart';
import 'package:sentinel_guard_app/src/api/user_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    CryptoService.saveKeyPair();
    super.initState();
  }

  Future<List<Bank>> futureBanks = UserApiService.getBanksList();
  TextEditingController bankCommunicationKey = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bank Communication Key'),
            content: TextField(
              controller: bankCommunicationKey,
              decoration: const InputDecoration(hintText: ""),
            ),
            actions: <Widget>[
              MaterialButton(
                // color: Colors.red,
                // textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                // color: Colors.green,
                // textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  // setState(() {
                  // codeDialog = valueText;
                  try {
                    UserApiService.addBank(bankCommunicationKey.text)
                        .then((value) =>
                            Navigator.pushReplacementNamed(context, '/layout'))
                        .catchError((err) {
                      Navigator.pop(context);
                      return null;
                    });
                  } catch (err) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to add bank")));
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  // String? codeDialog;
  // String? valueText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Scaffold(
          body: Center(
            child: FutureBuilder<List<Bank>>(
              future: futureBanks,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return BankListItem(bank: snapshot.data![index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Text('Add a bank to get started');
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayTextInputDialog(context);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class BankListItem extends StatefulWidget {
  const BankListItem({Key? key, required this.bank}) : super(key: key);
  final Bank bank;

  @override
  State<BankListItem> createState() => _BankListItemState();
}

class _BankListItemState extends State<BankListItem> {
  @override
  Widget build(BuildContext context) {
    Color customColor = Colors.lightBlue;
    return ListTile(
      onTap: () =>
          Navigator.pushNamed(context, '/bank', arguments: widget.bank),
      leading: Container(
        padding: const EdgeInsets.all(5),
        // backgroundColor: customColor,
        color: customColor,
        child: const Icon(
          Icons.account_balance,
          color: Colors.white,
        ),
      ),
      title: Text(widget.bank.name),
    );
  }
}
