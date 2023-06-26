import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/auth/services/auth_service.dart';

class NgoProfileView extends StatefulWidget {
  const NgoProfileView({super.key});

  @override
  State<NgoProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<NgoProfileView> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> logout() async {
    await AuthService.logOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: logout,
          child: const Text("Sair"),
        ),
      ),
    );
  }
}
