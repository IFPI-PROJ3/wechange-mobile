import 'package:flutter/material.dart';

var descText = const TextStyle(
  color: Colors.black38,
  fontWeight: FontWeight.w400,
  fontSize: 20,
);

Widget buildTextRegisterLogIn(
  String text,
  String text1,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('$text '),
      GestureDetector(
        onTap: () {},
        child: Text(
          text1,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF116B67),
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      )
    ],
  );
}

Widget buildTextTitle(
  String text,
) {
  return Text(
    text,
    style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
    textAlign: TextAlign.center,
  );
}

Widget buildTextButton(
  String text,
) {
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    ),
  );
}

var buildConfirmStyleButton = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF116B67),
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    minimumSize: const Size(double.infinity, 50),
    padding: const EdgeInsets.all(22));

InputDecoration inputDecorationTextForm(labelText, hintText) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF116B67)),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF116B67),
      ),
    ),
  );
}

InputDecoration inputDecorationTextFormPassword(labelText, hintText) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    // suffixIcon: IconButton(
    //   icon: const Icon( ? Icons.visibility_off_outlined : Icons.visibility_outlined),
    //   onPressed: () {
    //     setState() {
    //       verSenha = !verSenha;
    //     }
    //   },
    // ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF116B67)),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF116B67),
      ),
    ),
  );
}
