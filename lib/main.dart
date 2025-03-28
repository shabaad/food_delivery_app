import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      home: 
       HomeScreen(),
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
      ),
    );
  }
}
