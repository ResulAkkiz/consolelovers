import 'package:flutter/material.dart';

Row buildWrap(String value,
    {IconData? iconData, String? path, required String labelText}) {
  return Row(
    children: [
      iconData != null
          ? Icon(iconData)
          : SizedBox(height: 20, width: 25, child: Image.asset(path!)),
      Text('$labelText:$value'),
    ],
  );
}
