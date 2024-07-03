import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isLiked;
  final void Function()? onTap;
  const FavoriteButton({
    super.key,
    required this.isLiked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
- Input Field 
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const InputField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        style: const TextStyle(color: Color.fromARGB(255, 245, 250, 225)),
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 245, 250, 225)),
          contentPadding: const EdgeInsets.only(left: 24),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 245, 250, 225)),
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 245, 250, 225)),
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
