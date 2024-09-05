import 'transaction_model.dart';

class TransactionModel {
  final String id;
  final double amount;
  final Category category;
  final String date;
  final String paymentMethod;
  final String notes;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    required this.paymentMethod,
    required this.notes,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json['amount'],
      category: Category.fromJson(json['category']),
      date: json['date'],
      paymentMethod: json['paymentMethod'],
      notes: json['notes'],
      id: json['id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'category': category.toJson(),
      'date': date,
      'paymentMethod': paymentMethod,
      'notes': notes,
      'id':id
    };
  }
}
