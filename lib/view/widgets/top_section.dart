
import 'package:flutter/material.dart';

class TopSection extends StatefulWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  _TopSectionState createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Center(
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 232, 232, 232),
              ),
              child: const IconButton(
                onPressed: null,
                icon: Icon(Icons.filter_alt),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          TopMenuTiles(
            name: "Salads",
          ),
          TopMenuTiles(
            name: "Pizza",
          ),
          TopMenuTiles(
            name: "Beverages",
          ),
          TopMenuTiles(
            name: "Snacks",
          ),
        ],
      ),
    );
  }
}

class TopMenuTiles extends StatelessWidget {
  final String name;

  TopMenuTiles({
    Key? key,
    required this.name,
  }) : super(key: key);
  var page = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      child: Row(
        children: [
          Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 232, 232, 232),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                      color: Color.fromARGB(255, 255, 254, 254),
                      blurRadius: 25.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ]),
              child: Center(
                child: Text(name,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 3, 3, 3),
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              )),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
