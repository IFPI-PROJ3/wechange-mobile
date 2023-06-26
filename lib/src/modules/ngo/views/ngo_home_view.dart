import 'package:flutter/material.dart';

class NgoHomeView extends StatefulWidget {
  const NgoHomeView({super.key});

  @override
  State<NgoHomeView> createState() => _NgoHomeViewState();
}

class _NgoHomeViewState extends State<NgoHomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
