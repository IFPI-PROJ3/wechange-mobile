import 'package:flutter/material.dart';

class VolunteerSignUpView extends StatefulWidget {
  const VolunteerSignUpView({super.key});

  @override
  State<VolunteerSignUpView> createState() => _VolunteerSignUpView();
}

class _VolunteerSignUpView extends State<VolunteerSignUpView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pushReplacementNamed(context, '/signup-view'),
        ),
      ),
    );
  }
}
