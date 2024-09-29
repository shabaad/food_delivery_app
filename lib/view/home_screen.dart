import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_delivery/view/widgets/cart_button.dart';
import 'package:get/get.dart';
import 'package:food_delivery/view/cart_screen.dart';

import '../controller/controller.dart';
import 'widgets/food_items_list.dart';
import 'widgets/top_section.dart';

String address = "100a Ealing Rd . 24 mins";
bool pressed = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Controller controller = Get.put(Controller());
  Widget customCarousel() {
    return Column(
      children: [
        Stack(alignment: Alignment.bottomCenter, children: [
          MouseRegion(
            cursor: SystemMouseCursors.allScroll,
            child: CarouselSlider(
              carouselController: controller.carouselController,
              options: CarouselOptions(
                height: 300.0,
                viewportFraction: 1,
                initialPage: 0,
                autoPlay: false,
                enlargeCenterPage: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.hardEdge,
                onPageChanged: (index, reason) {
                  controller.currentIndex.value = index;
                },
              ),
              items: controller.pics.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xff87C6FE), Color(0xffCBCAFF)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 170, left: 0),
                                  child: Text(
                                    "Two slices of Pizza\nwith delicious salami",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 170),
                                  child: Container(
                                    height: 43,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(49),
                                      color: Colors.black,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "\$12.40",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Image.asset(
                            i,
                            height: 190,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ]),
        const SizedBox(height: 20),
        // Indicator
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.pics.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () =>
                    controller.carouselController.animateToPage(entry.key),
                child: Container(
                  width: 40.0,
                  height: 5.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: (controller.currentIndex.value == entry.key
                        ? Colors.black
                        : Colors.grey),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget customAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const IconButton(
            onPressed: null,
            padding: EdgeInsets.only(top: 60, left: 20),
            icon: Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            )),
        Container(
          padding: const EdgeInsets.only(top: 60),
          child: Container(
            height: 45,
            width: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(49),
              color: Colors.black,
            ),
            // ignore: prefer_const_constructors
            child: Center(
              child: Text(
                address,
                style: const TextStyle(
                    //backgroundColor: Colors.black,
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                    ),
              ),
            ),
          ),
        ),
        const IconButton(
            onPressed: null,
            padding: EdgeInsets.only(top: 60, right: 20),
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          primary: true,
          // physics: const ClampingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            customAppBar(),
            Container(
              padding: const EdgeInsets.only(top: 40, left: 30),
              child: const Text(
                "Hits of the week",
                textAlign: TextAlign.start,
                // ignore: prefer_const_constructors
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            customCarousel().animate().move(duration: Duration(seconds: 1),).fade(),
            const SizedBox(
              width: 15,
            ),

            const TopSection().animate().flip(duration: Duration(milliseconds: 500)),
            const FoodList()
            //  need to add one slider
          ].animate(interval: Duration(milliseconds: 50)).move().fade()),

          // ignore: prefer_const_constructors
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() => controller.cartItems.isEmpty
          ? SizedBox()
          : InkWell(
              onTap: () {
                showCupertinoModalPopup(
                  barrierColor: Colors.white,
                  // expand: true,
                  // isDismissible: true,
                  // barrierColor: const Color(0xFFBFC7C7),
                  // enableDrag: true,
                  //           isScrollControlled: true,

                  // // topRadius: const Radius.circular(50),
                  // // bounce: true,
                  context: context,
                  // elevation: 1.5,
                  // // animationCurve: Curves.easeInOutBack,
                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                  // // shadow: const BoxShadow(
                  // //   color: Color.fromARGB(255, 235, 230, 230),
                  // //   blurRadius: 20.0,
                  // //   offset: Offset(0.0, 0.75),
                  // // ),
                  // backgroundColor: Colors.white,
                  builder: (context) => CartScreen(),
                );
              },
              child: cartButton('Pay', controller))),
    );
  }
}
