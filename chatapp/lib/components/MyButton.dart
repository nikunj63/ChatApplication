import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
   const Mybutton({
    super.key,
    required this.onTap,
    required this.text

    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:const EdgeInsets.all(25),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:  Colors.blueGrey.shade900
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
            ),
        ),
      ),
    );
  }
}