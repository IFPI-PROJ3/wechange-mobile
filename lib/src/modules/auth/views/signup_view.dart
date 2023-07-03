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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pushReplacementNamed(context, '/signin-view'),
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                    shape: const StadiumBorder(),
                    shadowColor: Colors.black,
                    side: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: volunteerSignUp,
                  child: const Text("Registrar-se como voluntário"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                      shape: const StadiumBorder(),
                      shadowColor: Colors.black,
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: ngoSignUp,
                    child: const Text("Registrar-se como ONG")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
