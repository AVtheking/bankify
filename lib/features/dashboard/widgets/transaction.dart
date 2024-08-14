import 'package:bankify/models/transaction_model.dart';
import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  final TransactionModel transaction;
  const Transaction({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final color = (!transaction.isSent) ? Colors.red : Colors.green;
    return Card(
      child: ListTile(
        leading: const CircleAvatar(),
        title: Text(transaction.title, style: TextStyle(color: color)),
        subtitle: Text(transaction.date.toString()),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              (transaction.isSent) ? Icons.arrow_downward : Icons.arrow_upward,
              color: color,
            ),
            Text(transaction.amount.toString(),
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                )),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}
