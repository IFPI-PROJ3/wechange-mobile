import 'package:flutter/material.dart';

class VolunteerView extends StatefulWidget {
  const VolunteerView({super.key});

  static String route = '/ngo-initial-view';

  @override
  State<VolunteerView> createState() => _VolunteerViewState();
}

class _VolunteerViewState extends State<VolunteerView> {
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
