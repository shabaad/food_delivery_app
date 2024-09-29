import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_delivery/controller/controller.dart';
import 'package:get/get.dart';

Widget cartButton(String title, Controller controller) {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.black,
    ),
    margin: const EdgeInsets.symmetric(
      horizontal: 15,
    ),
    // ignore: prefer_const_constructors
    child: Row(
      // ignore: prefer_const_literals_to_create_immutables
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              decoration: TextDecoration.none,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            Text(
              '24 mins   ',
              style: const TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            CircleAvatar(
              radius: 3,
            ),
            Obx(
              () => Text(
                '  \$${controller.total.value}',
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    ),
  ).animate().move(
        delay: Duration(milliseconds: 200),
        begin: Offset(0, 100),
      );
}
