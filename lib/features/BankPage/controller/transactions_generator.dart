import 'dart:math';

import 'package:bankify/models/transaction_model.dart';

class TransactionsGenerator {
  static Future<List<TransactionModel>> generateRandomTransactions(
      int startId, int count) async {
    await Future.delayed(const Duration(seconds: 1));
    final Random random = Random();
    final List<String> titles = [
      'Grocery',
      'Online Shopping',
      'Restaurant',
      'Utilities',
      'Rent',
      'Salary',
      'Gift',
      'Insurance',
      'Entertainment',
      'Miscellaneous'
    ];

    return List<TransactionModel>.generate(count, (index) {
      final id = startId + index;
      final title = titles[random.nextInt(titles.length)];
      final amount = (random.nextDouble() * 1000).round();
      final date = DateTime.now().subtract(Duration(days: random.nextInt(365)));
      final isSent = random.nextBool();

      return TransactionModel(
        id: 'T$id',
        title: title,
        amount: amount.toDouble(),
        date: date,
        isSent: isSent,
      );
    });
  }

  //simulate api call
  static Future<List<TransactionModel>> fetchTransactions(
      int startId, int count) async {
        try{
          return await generateRandomTransactions(startId, count);
        } catch(e) {
          return [];
        }
  }
}
