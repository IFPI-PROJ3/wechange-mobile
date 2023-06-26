import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/auth/models/user_status.dart';
import 'package:wechange_mobile/src/modules/auth/views/ngo_signup_view.dart';
import 'package:wechange_mobile/src/modules/auth/views/signup_view.dart';
import 'package:wechange_mobile/src/modules/auth/views/volunteer_signup_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_view.dart';
import 'package:wechange_mobile/src/modules/volunteer/views/volunteer_home_view.dart';
import 'package:wechange_mobile/src/modules/volunteer/views/volunteer_view.dart';
import 'package:wechange_mobile/src/styles/theme_we_change.dart';
import 'src/modules/auth/services/auth_service.dart';
import 'src/modules/auth/views/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget loadUserHome() {
    if (AuthService.user!.role == 'Ngo') {
      return const NgoView();
    } else if (AuthService.user!.role == 'Volunteer') {
      return const VolunteerHomeView();
    } else {
      return const LoginView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Change',
      debugShowCheckedModeBanner: false,
      theme: default_theme,
      home: FutureBuilder<UserStatus?>(
        future: AuthService.getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<UserStatus?> snapshot) {
          if (snapshot.hasData) {
            return loadUserHome();
          } else {
            return const LoginView();
          }
        },
      ),
      routes: {
        '/signin-view': (context) => const LoginView(),
        '/ngo-view': (context) => const NgoView(),
        '/volunteer-view': (context) => const VolunteerView(),
        '/signup-view': (context) => const SignUpView(),
        '/signup-ngo': (context) => const NgoSignUpView(),
        '/signup-volunteer': (context) => const VolunteerSignUpView()
      },
    );
  }
}
