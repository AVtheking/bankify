import 'package:bankify/features/dashboard/widgets/bank_card.dart';
import 'package:bankify/features/dashboard/widgets/transaction.dart';
import 'package:bankify/models/transaction_model.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    color: const Color.fromRGBO(24, 26, 111, 1),
                  ),
                ),
                Positioned(
                  top: 35,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Available Balance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const Text(
                        '\$8000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  child: const BankCards(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: null,
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Color.fromRGBO(24, 26, 111, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                children: List.generate(allTransactions.length, (index) {
                  return Transaction(transaction: allTransactions[index]);
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<TransactionModel> allTransactions = [
  TransactionModel(
      title: 'Ankit',
      amount: 2000,
      date: DateTime.now().subtract(const Duration(days: 10)),
      isSent: false),
  TransactionModel(
      title: 'Ankit',
      amount: 10,
      date: DateTime.now().subtract(const Duration(days: 120)),
      isSent: true),
  TransactionModel(
      title: 'Ankit',
      amount: 200,
      date: DateTime.now().subtract(const Duration(days: 180)),
      isSent: false),
  TransactionModel(
      title: 'Ankit', amount: 2200, date: DateTime.now(), isSent: true),
  TransactionModel(
      title: 'Ankit', amount: 1500, date: DateTime.now(), isSent: false),
  TransactionModel(
      title: 'Ankit', amount: 0, date: DateTime.now(), isSent: true),
  TransactionModel(
      title: 'Ankit', amount: 400, date: DateTime.now(), isSent: false),
  TransactionModel(
      title: 'Ankit',
      amount: 2000,
      date: DateTime.now().subtract(const Duration(days: 10)),
      isSent: false),
  TransactionModel(
      title: 'Ankit',
      amount: 10,
      date: DateTime.now().subtract(const Duration(days: 120)),
      isSent: true),
  TransactionModel(
      title: 'Ankit',
      amount: 200,
      date: DateTime.now().subtract(const Duration(days: 180)),
      isSent: false),
  TransactionModel(
      title: 'Ankit', amount: 2200, date: DateTime.now(), isSent: true),
  TransactionModel(
      title: 'Ankit', amount: 1500, date: DateTime.now(), isSent: false),
  TransactionModel(
      title: 'Ankit', amount: 0, date: DateTime.now(), isSent: true),
  TransactionModel(
      title: 'Ankit', amount: 400, date: DateTime.now(), isSent: false),
];
