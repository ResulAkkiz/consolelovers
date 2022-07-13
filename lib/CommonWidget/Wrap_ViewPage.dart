import 'package:flutter/material.dart';

Row buildWrap(String value,
    {required IconData iconData, required String labelText}) {
  return Row(
    children: [
      Icon(iconData),
      Text('$labelText:$value'),
    ],
  );
}
