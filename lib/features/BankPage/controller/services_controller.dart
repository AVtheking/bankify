import 'package:bankify/features/BankPage/services/bank_services.dart';
import 'package:bankify/models/failure_model.dart';
import 'package:bankify/models/success_model.dart';
import 'package:bankify/models/transaction_model.dart';
import 'package:either_dart/either.dart';

class ServicesController {
  static Future<List<TransactionModel>?> getTransactions() async {
    Either<Success, Failure> response =
        await BankServices.handleGetTransactions();
    if (response.isLeft) {
      Success success = response.left;
      return TransactionModel.transactionModelsFormJson(success.data);
    } else {
      Failure failure = response.right;
      print(failure);
      return null;
    }
  }
}
