import 'package:expansivetrakingapp/controller/transaction_controller.dart';
import 'package:expansivetrakingapp/model/expansive_model.dart';
import 'package:expansivetrakingapp/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/expansive_controller.dart';

class AddExpansiveView extends StatefulWidget {
  const AddExpansiveView({super.key});

  @override
  State<AddExpansiveView> createState() => _AddExpansiveViewState();
}

class _AddExpansiveViewState extends State<AddExpansiveView> {
  var amountController = TextEditingController();
  var categoryController = TextEditingController();
  var dateController = TextEditingController();
  var paymentMethodController = TextEditingController();
  var notesController = TextEditingController();
  final controller = Get.find<CategoryController>();
  final expansiveController = Get.find<ExpansiveController>();

  final formkey = GlobalKey<FormState>();

  DateTime? selecteddate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: selecteddate ?? DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selecteddate) {
      setState(() {
        selecteddate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Expansive',
        style: TextStyle(
          fontWeight: FontWeight.w500
        ),),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    height: 55,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      
                      controller: amountController,
                      
                      decoration: InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 30),
        
                  Container(
                    height: 55,
                    decoration: BoxDecoration(),
                    child: Obx(() {
                      if (controller.categories.isEmpty) {
                        return CircularProgressIndicator();
                      }
                      if (!controller.categories
                          .contains(controller.selectedCategory.value)) {
                        controller.selectedCategory.value =
                            controller.categories.first;
                      }
                      return DropdownButtonFormField<Category>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5, left: 10),
                            labelText: 'Select category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          value: null,
                          items: controller.categories
                              .map<DropdownMenuItem<Category>>(
                                  (Category category) {
                            return DropdownMenuItem<Category>(
                                value: category,
                                child: controller.categories.isNotEmpty
                                    ? Text(category.name)
                                    : Text('Select iteam'));
                          }).toList(),
                          onChanged: (Category? newvalue) {
                            controller.selectedCategory(newvalue);
                          });
                    }),
                  ),
        
                  SizedBox(height: 30),
                  // Obx(() {
                  //   return Image.asset(
                  //     controller.selectedCategory.value.imagePath,
                  //     height: 100,
                  //   );
                  // }),
                  Container(
                    height: 55,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onTap: () {
                        setState(() {
                          selectDate(context);
                        });
                      },
                      controller: dateController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month_outlined),
                          labelText: 'Date',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 55,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      controller: paymentMethodController,
                      decoration: InputDecoration(
                          labelText: 'Payment Method',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 55,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: notesController,
                      decoration: InputDecoration(
                          labelText: 'Notes',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: ElevatedButton(
          onPressed: () {
          String id='';
            TransactionModel newTransaction = TransactionModel(
              amount: double.parse(amountController.text),
              category: controller.selectedCategory.value,
              date: dateController.text,
              notes: notesController.text,
              paymentMethod: paymentMethodController.text, 
            id: id
            );

            expansiveController.addtransaction(newTransaction);
            expansiveController.update();
            Get.back();
          },
          child: Text(
            'Save Income',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
