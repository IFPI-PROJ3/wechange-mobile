import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/auth/views/login_view.dart';
import 'package:wechange_mobile/src/modules/auth/views/ngo_signup_view.dart';
import 'package:wechange_mobile/src/modules/auth/views/volunteer_signup_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static String route = "/signup-options";

  @override
  State<SignUpView> createState() => _SignUpView();
}

class _SignUpView extends State<SignUpView> {
  @override
  void initState() {
    super.initState();
  }

  void volunteerSignUp() {
    Navigator.pushReplacementNamed(context, VolunteerSignUpView.route);
  }

  void ngoSignUp() {
    Navigator.pushReplacementNamed(context, NgoSignUpView.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pushReplacementNamed(context, LoginView.route),
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
