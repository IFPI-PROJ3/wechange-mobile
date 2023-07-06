import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/common/models/event_info.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_events_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_view.dart';

class EventEditView extends StatefulWidget {
  const EventEditView(this._event, {super.key});

  static String route = '/event-edit-view';

  final EventInfo _event;

  @override
  State<EventEditView> createState() => _EventEditView();
}

class _EventEditView extends State<EventEditView> {
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text(widget._event.title!),
      ),
    );
  }
}
