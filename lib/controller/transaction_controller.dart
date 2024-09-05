import 'package:expansivetrakingapp/model/transaction_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var selectedCategory = Category(name: 'None',
   imagePath: 'assets/images/placeholder.png',).obs;

  List<Category> categories = [
  
    Category(name: 'Food', imagePath: 'assets/icons/cutlery.png',),
    Category(name: 'Health Care', imagePath: 'assets/icons/healthcare.png',),
    Category(name: 'Shopping', imagePath: 'assets/icons/trolley.png',),
    Category(name: 'Others', imagePath: 'assets/icons/menu.png',)
    // Add more categories as needed
  ];

  void selectCategory(Category category) {
    selectedCategory.value = category;
  }
}