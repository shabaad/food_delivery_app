import 'package:flutter/material.dart';

class DynamicIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const DynamicIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: const Color.fromARGB(255, 234, 230, 230),
        boxShadow: [
          const BoxShadow(
            color: Color.fromARGB(255, 255, 254, 254),
            blurRadius: 25.0,
            offset: Offset(0.0, 0.75),
          ),
        ],
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
