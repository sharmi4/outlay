import 'dart:ffi';

import 'package:expansivetrakingapp/service/transaction_service.dart';
import 'package:get/get.dart';
import '../model/expansive_model.dart';

class ExpansiveController extends GetxController {
  List<TransactionModel> transactionmodel = [];
  final TransactionService transactionService = TransactionService();

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  Future<void> addtransaction(TransactionModel expansiveModel) async {
    transactionmodel.add(expansiveModel);
    await TransactionService.saveTransactions(transactionmodel);
  }

  Future<void> loadTransactions() async {
    var loadedTransaction = await TransactionService.loadTransactions();
    if (loadedTransaction != null) {
      transactionmodel = loadedTransaction;
    }
    update();
  }

  void deleteTransaction(int index) async {
    print('Controller: Deleting transaction with id: $index');

    await transactionService
        .deleteTransaction(index); // Use ID to delete from storage
    transactionmodel.removeAt(index);
    print('Controller: Transaction deleted');

    update(); // Then update the observable list
  }

  void updatetransaction(int index, TransactionModel updateTransaction) async {
    transactionmodel[index] = updateTransaction;
    await transactionService.updateTransaction(index, updateTransaction);
    update();
  }

  double getTotalBalance() {
    return transactionmodel.fold(0, (sum, item) => sum + item.amount);
  }
}
