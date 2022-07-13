import 'package:flutter/material.dart';

TextFormField textFormFieldConsoleAdd(
    {TextEditingController? controller,
    IconData? icon,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType? keyboardType}) {
  return TextFormField(
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
          icon: icon == null
              ? null
              : Icon(
                  icon,
                  color: Colors.white,
                ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white)),
      onSaved: (String? value) {},
      validator: validator);
}
