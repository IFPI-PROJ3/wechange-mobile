import 'package:flutter/material.dart';

class EventRequests extends StatefulWidget {
  const EventRequests({super.key});

  static String route = '/ngo-events-request-view';
  @override
  State<EventRequests> createState() => _EventRequestsState();
}

class _EventRequestsState extends State<EventRequests> {
  @override
  void initState() {
    super.initState();
  }

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
