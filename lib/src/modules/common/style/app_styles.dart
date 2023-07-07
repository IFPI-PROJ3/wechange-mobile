import 'package:flutter/material.dart';

InputDecoration inputDecorationBookingIcon(BuildContext context, txt, icon) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: txt,
    labelStyle: const TextStyle(color: Colors.white),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(5),
        topLeft: Radius.circular(5),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(5),
        topLeft: Radius.circular(5),
      ),
    ),
    prefixIcon: Icon(
      icon,
      color: Theme.of(context).primaryColor,
    ),
  );
}
