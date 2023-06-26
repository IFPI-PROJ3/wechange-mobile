import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Home Page',
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () async {
              bool out = await singOut();
              if (out) {
                Navigator.pushReplacementNamed(context, '/welcomePage');
              }
            },
            child: const Text('Sair'),
          )
        ],
      ),
    );
  }

  Future<bool> singOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}
