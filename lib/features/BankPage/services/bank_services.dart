import 'dart:convert';

import 'package:bankify/models/failure_model.dart';
import 'package:bankify/models/success_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BankServices { 

  static Future<Either<Success,Failure>> handleGetTransactions() async {
    String baseUrl = dotenv.get('BASE_URL');
    String url = '$baseUrl/transactions';
    try{
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final responseBody = jsonDecode(response.body);
        return Left(Success(message: responseBody['message'], data: responseBody['data']));
      }else{
        return Right(Failure('Failed to fetch transactions'));
      }
    }
    catch(e){
      return Right(Failure('Failed to fetch transactions: $e'));
    }
  }

}