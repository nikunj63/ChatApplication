import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final Controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.Controller,
    required this.hintText,
    required this.obscureText,
    re
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: Controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white)
        ),
        fillColor: Colors.grey[100],
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black45)
        
      ),
    );
  }
}