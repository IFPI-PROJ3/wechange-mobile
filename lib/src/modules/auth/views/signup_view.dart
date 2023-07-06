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
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/signin-view'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                
                onPressed: volunteerSignUp,
                child: const Text("Registrar-se como voluntário"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: ngoSignUp,
                  child: const Text("Registrar-se como ONG")),
            ],
          ),
        ),
      ),
    );
  }
}
