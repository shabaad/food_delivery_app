import 'package:get/get.dart';

class FoodItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  FoodItem({required this.id, required this.name, required this.price, required this.imageUrl});
}

class CartItem {
  final FoodItem foodItem;
  RxInt quantity; // Make the quantity reactive

  CartItem({
    required this.foodItem,
    int initialQuantity = 1, // Use a normal int instead
  }) : quantity = RxInt(initialQuantity); // Initialize without const
}
