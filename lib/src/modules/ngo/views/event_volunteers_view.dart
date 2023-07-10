import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/common/models/event_info.dart';
import 'package:wechange_mobile/src/modules/common/widgets/request_card.dart';
import 'package:wechange_mobile/src/modules/ngo/models/volunteer_request.dart';
import 'package:wechange_mobile/src/modules/ngo/services/event_volunteer_service.dart';

class EventVolunteersView extends StatefulWidget {
  const EventVolunteersView(this._event, {super.key});

  //final Function eventCallback;
  final EventInfo _event;

  static String route = '/ngo-event-participants-view';

  @override
  State<EventVolunteersView> createState() => _EventVolunteersViewState();
}

class _EventVolunteersViewState extends State<EventVolunteersView> {
  @override
  void initState() {
    super.initState();
  }

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VolunteerRequest>>(
      future: EventVolunteerService.getEventVolunteers(widget._event),
      builder: (BuildContext context, AsyncSnapshot<List<VolunteerRequest>> snapshot) {
        if (snapshot.hasData) {
          return buildRequestsList(context, snapshot.data!);
        } else {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget buildRequestsList(BuildContext context, List<VolunteerRequest> requestList) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          requestList.length == 1
              ? '${requestList.length.toString()} Participante'
              : '${requestList.length.toString()} Participantes',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          ...requestList.map((request) => RequestCard(callback, request, RequestCardOptions.confirmed)).toList(),
        ],
      ),
    );
  }
}
