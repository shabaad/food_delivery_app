import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:food_delivery/model/model.dart';

class Controller extends GetxController {
  final CarouselController carouselController = CarouselController();
  var currentIndex = 0.obs; // Observed variable to track current page index
  
  var cartItems = <CartItem>[].obs;
  var total = 0.0.obs;

  RxInt count = 1.obs;
  void addQuantity() {
    count.value++;
  }

  void removeQuantity() {
    (count.value > 1) ? count.value-- : count.value;
  }


  RxInt cutleryCount = 1.obs;

  void addCutleryCount() {
      cutleryCount.value++;
  }

  void removeCutleryCount() {
      (cutleryCount.value > 1) ? cutleryCount.value-- : cutleryCount.value;
  }


  void addToCart(FoodItem foodItem) {
    var existingItem =
        cartItems.firstWhereOrNull((item) => item.foodItem.id == foodItem.id);
    if (existingItem != null) {
      existingItem.quantity.value++; // Update reactive quantity
    } else {
      cartItems.add(CartItem(foodItem: foodItem));
    }
    // Automatically update total
    total.value = _calculateTotalAmount();
  }

  void removeFromCart(CartItem cartItem) {
    if (cartItem.quantity.value > 1) {
      cartItem.quantity.value--; // Update reactive quantity
    } else {
      cartItems.remove(cartItem);
    }
    // Automatically update total
    total.value = _calculateTotalAmount();
  }

  double _calculateTotalAmount() {
    return cartItems.fold(
        0, (sum, item) => sum + (item.foodItem.price * item.quantity.value));
  }

    final List<String> pics = [
    'image/assets/Pizza.png',
    'image/assets/Banana.png',
    'image/assets/Candies.png',
    'image/assets/Cookie.png',
    'image/assets/Dessert.png',
    'image/assets/Dessert2.png',
    'image/assets/Food-Plate.png',
  ];


  var foodItems = <FoodItem>[
    FoodItem(
      id: '1',
      name: 'Poke with chicken \nand corn',
      price: 47.00,
      imageUrl: 'image/assets/Grilled-Chicken.png',
    ),
    FoodItem(
      id: '2',
      name: 'Salad with radishes,\ntomatoes and mushrooms',
      price: 89.00,
      imageUrl: 'image/assets/Salad2.png',
    ),
  ].obs;


}
