import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/common/models/event_info.dart';
import 'package:wechange_mobile/src/modules/common/widgets/request_card.dart';
import 'package:wechange_mobile/src/modules/ngo/models/volunteer_request.dart';
import 'package:wechange_mobile/src/modules/ngo/services/event_volunteer_service.dart';

class EventRequestsView extends StatefulWidget {
  const EventRequestsView(this._event, {super.key});

  //final Function eventCallback;
  final EventInfo _event;

  static String route = '/ngo-event-request-view';

  @override
  State<EventRequestsView> createState() => _EventRequestsState();
}

class _EventRequestsState extends State<EventRequestsView> {
  @override
  void initState() {
    super.initState();
  }

  void callback() {
    Navigator.pop(context, true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VolunteerRequest>>(
      future: EventVolunteerService.getEventRequests(widget._event),
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
              ? '${requestList.length.toString()} Solicitação'
              : '${requestList.length.toString()} Solicitações',
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
          ...requestList.map((request) => RequestCard(callback, request, RequestCardOptions.undefined)).toList(),
        ],
      ),
    );
  }
}
