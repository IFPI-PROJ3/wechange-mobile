import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/auth/services/auth_service.dart';
import 'package:wechange_mobile/src/modules/auth/views/login_view.dart';
import 'package:wechange_mobile/src/modules/auth/views/ngo_signup_view.dart';
import 'package:wechange_mobile/src/modules/auth/views/signup_view.dart';
import 'package:wechange_mobile/src/modules/auth/views/volunteer_signup_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_events_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_view.dart';
import 'package:wechange_mobile/src/modules/volunteer/views/volunteer_home_view.dart';
import 'package:wechange_mobile/src/modules/volunteer/views/volunteer_view.dart';
import 'package:wechange_mobile/src/styles/theme_we_change.dart';

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
      theme: defaultTheme,
      home: FutureBuilder<bool>(
        future: AuthService.getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return loadUserHome();
            } else {
              return const LoginView();
            }
          } else {
            return const LoginView();
          }
        },
      ),
      routes: {
        //Auth
        '/signin-view': (context) => const LoginView(),
        '/signup-view': (context) => const SignUpView(),
        '/signup-ngo': (context) => const NgoSignUpView(),
        '/signup-volunteer': (context) => const VolunteerSignUpView(),

        //Ngo-Side
        '/ngo-view': (context) => const NgoView(),
        '/volunteer-view': (context) => const VolunteerView(),
        '/events-view': (context) => const NgoEventsView()
      },
    );
  }
}
