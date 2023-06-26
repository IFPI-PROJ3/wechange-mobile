import 'package:flutter/material.dart';

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
    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
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

// List<String> hobbyList = [
//   'Shopping',
//   'Comedy',
//   'Brunch',
//   'Music',
//   'Road Trips',
//   'Tea',
//   'Trivia',
//   'Comedy',
//   'Clubbing',
//   'Drinking',
//   'Wine',
//   'Hiking',
//   'Yoga',
//   'Volleyball',
//   'Craft Beer',
//   'Dogs',
//   'Cats',
//   'Activism',
//   'Vlogging',
//   'Museum',
//   'Dancing',
//   'Running',
//   'Singing',
//   'Make-Up',
//   'Concert',
//   'Cafe',
//   'Theater',
//   'Baking',
//   'Gardening',
//   'Cooking',
//   'Video Games',
//   'Camping'
// ];

// List<String>? selectedHobby = [];

// Widget buildMultipleChoices() {
//   return Wrap(
//     children: hobbyList.map(
//       (hobby) {
//         bool isSelected = false;
//         if (selectedHobby!.contains(hobby)) {
//           isSelected = true;
//         }
//         return GestureDetector(
//           onTap: () {
//             if (!selectedHobby!.contains(hobby)) {
//               if (selectedHobby!.length < 5) {
//                 selectedHobby!.add(hobby);
//                 print(selectedHobby);
//               }
//             } else {
//               selectedHobby!.removeWhere((element) => element == hobby);
//               print(selectedHobby);
//             }
//           },
//           child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(18),
//                     border: Border.all(
//                         color:
//                             isSelected ? Colors.grey : const Color(0xFF116B67),
//                         width: 2)),
//                 child: Text(
//                   hobby,
//                   style: TextStyle(
//                       color: isSelected ? Colors.grey : const Color(0xFF116B67),
//                       fontSize: 14),
//                 ),
//               )),
//         );
//       },
//     ).toList(),
//   );
// }
