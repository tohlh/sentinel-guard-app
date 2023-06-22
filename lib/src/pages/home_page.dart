import 'package:flutter/material.dart';
import 'package:sentinel_guard_app/src/models/bank.dart';
import 'package:sentinel_guard_app/src/api/user_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Bank>> futureBanks = UserApiService.getBanksList();

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
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return BankListItem(bank: snapshot.data![index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
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
    return ListTile(
      onTap: () {
        () => {
          Navigator.pushNamed(context, '/bank', arguments: widget.bank)
        };
      },
      leading: const Icon(Icons.account_balance),
      title: Text(widget.bank.name),
    );
  }
}
