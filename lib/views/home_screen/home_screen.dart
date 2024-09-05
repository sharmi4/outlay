import 'package:expansivetrakingapp/model/expansive_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/expansive_controller.dart';
import '../add_expansive/add_expansive_view.dart';
import '../add_expansive/edit_expansive_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    expansiveController.loadTransactions();
    super.initState();
  }

  final expansiveController = Get.find<ExpansiveController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<ExpansiveController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Container(
                height: 150,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Expansive',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '₹ ${expansiveController.getTotalBalance()}',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                 expansiveController.transactionmodel.isNotEmpty? Text('All Expansive'):Text('')
                  ],
              ),
              SizedBox(
                height: 40,
              ),
              GetBuilder<ExpansiveController>(builder: (_) {
                return expansiveController.transactionmodel.isNotEmpty? ListView.builder(
                    shrinkWrap: true,
                    itemCount: expansiveController.transactionmodel.length,
                    itemBuilder: (context, index) {
                      final transaction =
                          expansiveController.transactionmodel[index];
                      return 
                       Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: InkWell(
                              onLongPress: () {
                                showDeleteDialog(context, index);
                              },
                              child: InkWell(
                                onTap: () {
                                  showdetailsDialog(context, transaction);
                                },
                                child: Container(
                                  height: 80,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white54,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 8,
                                            offset: Offset(0.0, 0.75))
                                      ],
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  expansiveController
                                                      .transactionmodel[index]
                                                      .category
                                                      .imagePath,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        expansiveController
                                                            .transactionmodel[index]
                                                            .notes,
                                                      ),
                                                      Text(expansiveController
                                                          .transactionmodel[index]
                                                          .paymentMethod),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(expansiveController
                                                .transactionmodel[index].amount
                                                .toString())
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                               InkWell(
                      onTap: () {
                        Get.to(EditExpansiveView(
                          index: index, transaction: transaction,));
                      },
                      child: Icon(
                        Icons.edit_square,
                        color: Color(0xFF003366),
                      ),
                    )
                            ],
                          )
                        ],
                      );
                    }):Column(
                      children:[ 
                        Image.asset('assets/images/noexpansive.jpg',
                        height: 300,fit: BoxFit.fitHeight,),
                        Text('No Data',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),)
                        ]);
              }),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      }),
      floatingActionButton: InkWell(
          onTap: () {
            Get.to(AddExpansiveView());
          },
          child: Icon(
            Icons.add_circle,
            size: 40,
          )),
    );
  }

  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Transaction'),
          content: Text('Are you sure you want to delete this transaction?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                expansiveController.deleteTransaction(index);
                expansiveController.update();
                Get.back();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void showdetailsDialog(BuildContext context, TransactionModel transaction) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
              height: 350,
              child: Column(children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expansive Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                   
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: Image.asset(
                        transaction.category.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: 130,
                            child: Text(
                              'Category Name :',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            )),

                        Container(
                            width: 130,
                            child: Text(
                              'Amount :',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            )),

                        Container(
                            width: 130,
                            child: Text(
                              'Date :',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            )),

                        Container(
                            width: 130,
                            child: Text(
                              "Payment Method :",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            )),
                        //

                        Container(
                            width: 130,
                            child: Text(
                              'Nodes :',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            )),
                        //
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(transaction.category.name),
                          transaction.amount != null
                              ? Container(
                                  width: 100,
                                  child: Text(
                                    transaction.amount.toString(),
                                  ))
                              : Text('No data'),
                          Container(width: 100, child: Text(transaction.date)),
                          transaction.paymentMethod.isNotEmpty
                              ? Container(
                                  width: 100,
                                  child: Text(transaction.paymentMethod))
                              : Text('No data'),
                          transaction.notes.isNotEmpty
                              ? Container(
                                  width: 100, child: Text(transaction.notes))
                              : Text('No Data')
                        ],
                      ),
                    ),
                  ],
                ),
              ])),
        );
      },
    );
  }
}
