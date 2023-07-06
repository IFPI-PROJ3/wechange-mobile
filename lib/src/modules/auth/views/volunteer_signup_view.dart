import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/auth/views/signup_view.dart';

class VolunteerSignUpView extends StatefulWidget {
  const VolunteerSignUpView({super.key});

  static String route = '/signup-volunteer';

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
          onPressed: () => Navigator.pushReplacementNamed(context, SignUpView.route),
        ),
      ),
    );
  }
}
