

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:wechange_mobile/matsallz/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(microseconds: 2500), () {});

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSplashScreen(
              splash: '/home/alunos/Documentos/wechange-mobile-1/lib/src/assets/logo.png',
              
              nextScreen: const LoginPage(),
              duration: 2000,
              splashTransition: SplashTransition.fadeTransition,
              //pageTransitionType: PageTransitionsType.scale,
            ),
            /*
            Image(
              image: AssetImage('/home/alunos/Documentos/wechange-mobile-1/lib/src/assets/logo.png'),
            ),
            */
          ],
        ),
      ),
    );
  }
}
