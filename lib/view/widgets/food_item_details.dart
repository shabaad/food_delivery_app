import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controller/controller.dart';
import 'package:food_delivery/model/model.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../cart_screen.dart';

class FoodItemDetails extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  final String calories;
  final String description;
  final String grams;
  final String proteins;
  final String fats;
  final String carbs;
  final String title;
  final FoodItem item;

  const FoodItemDetails(
      {Key? key,
      required this.name,
      required this.image,
      required this.price,
      required this.calories,
      required this.description,
      required this.grams,
      required this.proteins,
      required this.fats,
      required this.carbs,
      required this.title,
      required this.item})
      : super(key: key);

  @override
  State<FoodItemDetails> createState() => _FoodItemDetailsState();
}

class _FoodItemDetailsState extends State<FoodItemDetails> {
  final controller = Get.find<Controller>();

  Widget customPageDesignNameImage() {
    return Center(
      child: Container(
          height: 290,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),

              //   ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(
                  color: Color.fromARGB(255, 228, 228, 233),
                  blurRadius: 25.0,
                  offset: Offset(0.0, 0.75),
                ),
              ]),
          child: Center(
            child: Image.asset(
              widget.image,
              height: 250,
              width: 250,
              fit: BoxFit.fill,
            ),
          )),
    );
  }

  Widget customQualityDesign() {
    return Container(
      height: 55,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 232, 232, 232),
          //   ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
              color: Color.fromARGB(255, 255, 254, 254),
              blurRadius: 25.0,
              offset: Offset(0.0, 0.75),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          Center(
            child: IconButton(
              onPressed: controller.removeQuantity,
              icon: Icon(Icons.remove),
            ),
          ),
          Center(
            child: Obx(
              () => Text(
                "${controller.count.value}",
                style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Center(
            child: IconButton(
              onPressed: controller.addQuantity,
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget addCartOption() {
    return Container(
      height: 55,
      width: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),

      // ignore: prefer_const_constructors
      child: TextButton(
        onPressed: () {
          for (int i = 0; i < controller.count.value; i++) {
            controller.addToCart(widget.item);
          }
          Get.back();
        },
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(
              child: Text(
                "Add to cart",
                style: TextStyle(
                    fontSize: 17,
                    decoration: TextDecoration.none,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w400),
              ),
            ),
            Center(
              child: Obx(
                () => RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$${controller.count.value * widget.price}',
                        style: const TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      primary: true,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        customPageDesignNameImage().animate().flipH(),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 15),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.name,
                  style: const TextStyle(
                      fontSize: 27,
                      color: Color(0xFF3a3a3b),
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 5),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.description,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.all(25),
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.black45,
                width: 0.2,
                style: BorderStyle.solid),

            //   ignore: prefer_const_literals_to_create_immutables
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemNutrition(
                  value: widget.calories,
                  title: 'kcal',
                ),
                ItemNutrition(
                  value: widget.grams,
                  title: 'grams',
                ),
                ItemNutrition(
                  value: widget.proteins,
                  title: 'protein',
                ),
                ItemNutrition(
                  value: widget.fats,
                  title: 'fat',
                ),
                ItemNutrition(
                  value: widget.carbs,
                  title: 'carbs',
                ),
              ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 15, right: 15),
              child: Text(
                "Add in ${widget.title}",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 28, left: 15, right: 15),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.black,
                )),
          ],
        ),
        Obx(
          () => controller.cartItems
                  .any((element) => element.foodItem.name == widget.name)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 232, 232, 232),
                        //   ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          const BoxShadow(
                            color: Color.fromARGB(255, 255, 254, 254),
                            blurRadius: 25.0,
                            offset: Offset(0.0, 0.75),
                          ),
                        ]),
                    child: Center(
                        child: Text(
                      'Added in Cart',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none),
                    )),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customQualityDesign(),
                      addCartOption(),
                    ],
                  ),
                ),
        ),
        const SizedBox(height: 20),
      ].animate(interval: Duration(milliseconds: 100)).slide().fade()),
    );
  }
}

class ItemNutrition extends StatelessWidget {
  const ItemNutrition({
    super.key,
    required this.value,
    required this.title,
  });

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
     
      Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 2, 2, 2),
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
     
    ]).animate(delay: Duration(milliseconds: 500)).flipH(duration: Duration(seconds: 1));
  }
}

// void showToast() {
//   Fluttertoast.showToast(
//       msg: 'This is toast notification',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIos: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.yellow);
// }

