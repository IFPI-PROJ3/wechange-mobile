import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpView();
}

class _SignUpView extends State<SignUpView> {
  @override
  void initState() {
    super.initState();
  }

  void volunteerSignUp() {
    Navigator.pushReplacementNamed(context, '/signup-volunteer');
  }

  void ngoSignUp() {
    Navigator.pushReplacementNamed(context, '/signup-ngo');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
            child: ElevatedButton(onPressed: volunteerSignUp, child: const Text("Registrar-se como voluntário")),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
            child: ElevatedButton(onPressed: ngoSignUp, child: const Text("Registrar-se como ONG")),
          ),
        ],
      ),
    );
  }
}
