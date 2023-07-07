import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/common/event_card.dart';
import 'package:wechange_mobile/src/modules/ngo/models/ngo_info.dart';
import 'package:wechange_mobile/src/modules/ngo/services/ngo_service.dart';

class NgoEventsView extends StatefulWidget {
  const NgoEventsView({super.key});

  static String route = '/ngo-events-view';
  @override
  State<NgoEventsView> createState() => _NgoEventsViewState();
}

class _NgoEventsViewState extends State<NgoEventsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ativos', icon: Icon(Icons.diversity_3_sharp)),
              Tab(text: 'Em breve', icon: Icon(Icons.diversity_3_outlined)),
              Tab(text: 'Finalizados', icon: Icon(Icons.close))
            ],
          ),
        ),
        body: FutureBuilder<bool>(
          future: NgoService.getNgoInfo(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              NgoInfo ngoInfo = NgoService.ngo!;
              return TabBarView(
                children: <Widget>[
                  ListView(
                    children: [
                      ...ngoInfo.currentEvents.map((event) => EventCard(event, EventCardOptions.current)).toList(),
                    ],
                  ),
                  ListView(
                    children: [
                      ...ngoInfo.upcomingEvents
                          .map((event) => EventCard(event, EventCardOptions.upcoming))
                          .toList(),
                    ],
                  ),
                  ListView(
                    children: [
                      ...ngoInfo.endedEvents.map((event) => EventCard(event, EventCardOptions.ended)).toList(),
                    ],
                  ),
                ],
              );
            } else {
              return Row();
            }
          },
        ),
      ),
    );
  }
}
