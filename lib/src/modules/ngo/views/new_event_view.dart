import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_view.dart';

class NewEventView extends StatefulWidget {
  const NewEventView({super.key});

  static String route = '/new-event-view';

  @override
  State<NewEventView> createState() => _NewEventView();
}

class _NewEventView extends State<NewEventView> {
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
          onPressed: () => Navigator.pushReplacementNamed(context, NgoView.route),
        ),
      ),
    );
  }
}
