import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/common/event_card.dart';
import 'package:wechange_mobile/src/modules/common/utils/geocoder_utils.dart';
import 'package:wechange_mobile/src/modules/ngo/views/widgets/info_widget.dart';
import 'package:wechange_mobile/src/modules/ngo/views/widgets/profile_widget.dart';
import 'package:wechange_mobile/src/modules/volunteer/models/volunteer_info.dart';
import 'package:wechange_mobile/src/modules/volunteer/services/volunteer_service.dart';

class VolunteerView extends StatefulWidget {
  const VolunteerView(this._volunteerId, {super.key});

  static String route = '/volunteer-view';

  final String _volunteerId;

  @override
  State<VolunteerView> createState() => _VolunteerViewState();
}

class _VolunteerViewState extends State<VolunteerView> with TickerProviderStateMixin {
  late TabController _tabController;
  String _addressDescription = "";

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _loadAddressDescription(VolunteerInfo volunteerInfo) async {
    _addressDescription = await GeoCoderUtils.getAddressByLatLng(volunteerInfo.latitude, volunteerInfo.longitude);
    setState(() {});
  }

  void callback() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do voluntário',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<VolunteerInfo?>(
        future: VolunteerService.getVolunteerInfoView(widget._volunteerId),
        builder: (BuildContext context, AsyncSnapshot<VolunteerInfo?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              _loadAddressDescription(snapshot.data as VolunteerInfo);
              return _listViewVolunteer(context, snapshot.data as VolunteerInfo);
            } else {
              const snackBar = SnackBar(
                content: Text('Não foi possível carregar a página inicial.'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _listViewVolunteer(BuildContext context, VolunteerInfo volunteerInfo) {
    int allevents = volunteerInfo.endedEvents.length;

    return Column(
      children: [
        const SizedBox(height: 10),
        ProfileWidget(imagePath: volunteerInfo.profile_image, size: 128),
        buildDescription(context, volunteerInfo.name + ' ' + volunteerInfo.lastName, volunteerInfo.description),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on),
            Text(
              _addressDescription,
              style: const TextStyle(color: Colors.black54),
            )
          ],
        ),
        const SizedBox(height: 10),
        infoVolunteerWidget(context, volunteerInfo.currentEvents.length, allevents, volunteerInfo.categories),
        const SizedBox(height: 10),
        TabBar(
          unselectedLabelColor: Colors.black54,
          tabs: const [
            Tab(
              text: 'Inscrições',
            ),
            Tab(
              text: 'Participações',
            )
          ],
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        Expanded(
          child: TabBarView(
            children: [
              ListView(
                children: [
                  ...volunteerInfo.upcomingEvents
                      .map((event) => EventCard(callback, event, EventCardOptions.exibition))
                      .toList(),
                ],
              ),
              ListView(
                children: [
                  ...volunteerInfo.endedEvents
                      .map((event) => EventCard(callback, event, EventCardOptions.exibition))
                      .toList(),
                ],
              ),
            ],
            controller: _tabController,
          ),
        ),
      ],
    );
  }

  Widget buildDescription(BuildContext context, String name, String descricao) => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            height: 80,
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  maxLines: 3,
                  descricao,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      );
}
