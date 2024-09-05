import 'dart:convert';
import 'package:expansivetrakingapp/model/expansive_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  static const String _transactionKey = 'transactions';

  static Future<void> saveTransactions(
      List<TransactionModel> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = transactions
        .map((transaction) => jsonEncode(transaction.toJson()))
        .toList();
    prefs.setStringList(_transactionKey, jsonList);
  }

  static Future<List<TransactionModel>?> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_transactionKey);
    if (jsonList == null) return null;
    return jsonList
        .map((jsonString) => TransactionModel.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  Future<void> deleteTransaction(int index) async {
    print('Deleting transaction with id: $index');
    List<TransactionModel>? transactions = await loadTransactions();
    transactions!.removeAt(index);
    await saveTransactions(transactions);
    print('Transaction deleted');
  }

  Future<void> updateTransaction(
      int index, TransactionModel transactionModel) async {
    List<TransactionModel>? updatedtransaction = await loadTransactions();
    updatedtransaction![index] = transactionModel;
    await saveTransactions(updatedtransaction);
  }
}
