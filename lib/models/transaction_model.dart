class TransactionModel {
  final String id;
  final String title;
  final bool isSent;
  final double amount;
  final DateTime date;

  const TransactionModel({
    this.id = '',
    this.isSent = false,
    required this.title,
    required this.amount,
    required this.date,
  });

  static List<TransactionModel> transactionModelsFormJson(List<dynamic> json) {
    List<TransactionModel> transactions = [];
    for (var transaction in json) {
      transactions.add(TransactionModel(
        id: transaction['id'],
        title: transaction['title'],
        amount: transaction['amount'],
        date: DateTime.parse(transaction['date']),
        isSent: transaction['isSent'],
      ));
    }
    return transactions;
  }
}
