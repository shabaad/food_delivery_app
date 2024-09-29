import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_delivery/model/model.dart';
import 'package:food_delivery/view/widgets/cart_button.dart';
import 'package:food_delivery/view/widgets/icon_button.dart';
import 'package:get/get.dart';
import 'package:food_delivery/view/home_screen.dart';

import '../controller/controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Controller controller = Get.find();

  Widget quantityMeasureProduct(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Decrease Button
              DynamicIconButton(
                icon: Icons.remove,
                onPressed: () =>
                    controller.removeFromCart(controller.cartItems[index]),
              ),

              const SizedBox(width: 10),
              // Quantity Display
              Center(
                child: Obx(() => Text(
                      '${controller.cartItems[index].quantity.value}',
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                    )),
              ),
              const SizedBox(width: 10),
              // Increase Button
              DynamicIconButton(
                icon: Icons.add,
                onPressed: () =>
                    controller.addToCart(controller.cartItems[index].foodItem),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget quantityMeasureExtraProduct() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              DynamicIconButton(
                icon: Icons.remove,
                onPressed: controller.removeCutleryCount,
              ),

              const SizedBox(width: 10),
              Center(
                child: Text(
                  '${controller.cutleryCount.value}',
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(width: 10),
              DynamicIconButton(
                icon: Icons.add,
                onPressed: controller.addCutleryCount,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      primary: true,
      child: Obx(() {
        if (controller.cartItems.isEmpty) {
          Get.back();
          Future.delayed(Duration(milliseconds: 100), () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Cart is empty'),
                  behavior: SnackBarBehavior.floating),
            );
          });

          return Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 2),
                  child: Text(
                    "Cart is empty",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          );
        }
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 15),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "We will deliver in \n24 minutes to the address:",
                        style: TextStyle(
                            fontSize: 25,
                            color: Color(0xFF3a3a3b),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: address.substring(0, 17),
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 13, 13, 14),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: const TextButton(
                      onPressed: null,
                      child: Text(
                        "Change Address",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = controller.cartItems[index];

                        return _cartItems(cartItem, index);
                      }),
                  const Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Divider(
                      height: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        Center(
                          child: const Icon(
                            Icons.soup_kitchen,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              "Cutlery",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF3a3a3b),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        quantityMeasureExtraProduct(),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 15, left: 15),
                    child: Divider(
                      height: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 15),
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Delivery",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 15),
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Free delivery above \$30",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        // ignore: prefer_const_constructors
                        child: Text(
                          "\$00.00",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF3a3a3b),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 15),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Payment Method",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black38,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                // ignore: prefer_const_literals_to_create_immutables
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.apple,
                                      size: 15,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      "Pay",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.none),
                                    ),
                                  ]),
                            ),
                            Text(
                              "  Apple pay",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    controller.cartItems.clear();
                    Future.delayed(Duration(milliseconds: 100), () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Order placed successfully'),
                            behavior: SnackBarBehavior.floating),
                      );
                    });
                    Get.back();
                  },
                  child: Material(child: cartButton('Pay', controller))),
              const SizedBox(
                height: 50,
              ),
            ]
                .animate(interval: Duration(milliseconds: 50))
                .slideX(begin: 2)
                .fade());
      }),
    );
  }

  Row _cartItems(CartItem cartItem, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.only(left: 10, right: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(
                  color: Color.fromARGB(255, 211, 205, 205),
                  blurRadius: 25.0,
                  offset: Offset(0.0, 0.75),
                ),
              ]),
          child: Image.asset(
            cartItem.foodItem.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        // ignore: prefer_const_constructors

        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 7),
                child: Text(
                  cartItem.foodItem.name,
                  style: const TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      color: Color(0xFF3a3a3b),
                      fontWeight: FontWeight.w400),
                ),
              ),
              quantityMeasureProduct(index),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     IconButton(
              //       icon: Icon(Icons.remove),
              //       onPressed: () =>
              //           cartController.removeFromCart(cartItem),
              //     ),
              //     Obx(() => Text(
              //         '${cartController.cartItems[index].quantity}')), // Display the current quantity
              //     IconButton(
              //       icon: Icon(Icons.add),
              //       onPressed: () => cartController
              //           .addToCart(cartItem.foodItem),
              //     ),
              //   ],
              // )
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 2, right: 15),
          child: Obx(
            () => Text(
              '\$${cartItem.foodItem.price * cartItem.quantity.value}',
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
