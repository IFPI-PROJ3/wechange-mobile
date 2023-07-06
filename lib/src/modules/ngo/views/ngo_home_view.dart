import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/common/api_params.dart';
import 'package:wechange_mobile/src/modules/common/utils/geocoder_utils.dart';
import 'package:wechange_mobile/src/modules/ngo/models/ngo_info.dart';
import 'package:wechange_mobile/src/modules/ngo/services/ngo_service.dart';
import 'package:wechange_mobile/src/modules/ngo/views/new_event_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/widgets/appbar_widget.dart';
import 'package:wechange_mobile/src/modules/ngo/views/widgets/info_widget.dart';
import 'package:wechange_mobile/src/modules/ngo/views/widgets/profile_widget.dart';

class NgoHomeView extends StatefulWidget {
  const NgoHomeView({super.key});

  @override
  State<NgoHomeView> createState() => _NgoHomeViewState();
}

class _NgoHomeViewState extends State<NgoHomeView> {
  String _addressDescription = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadAddressDescription() async {
    NgoInfo ngo = NgoService.ngo!;
    _addressDescription = await GeoCoderUtils.getAddressByLatLng(ngo.latitude, ngo.longitude);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder<bool>(
        future: NgoService.getNgoInfo(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              loadAddressDescription();
              return listViewNgo(context);
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

  Widget listViewNgo(BuildContext context) {
    NgoInfo ngo = NgoService.ngo!;
    int allevents = ngo.currentEvents.length + ngo.upcomingEvents.length + ngo.endedEvents.length;
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 10),
        ProfileWidget(imagePath: "${ApiParams.s3BucketBaseUrl}/d1c68195-f9d3-43ba-93c8-35f937286ab7", size: 128),
        buildDescription(context, NgoService.ngo!.name, NgoService.ngo!.description),
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
        infoWidget(context, ngo.averageRating, ngo.currentEvents.length, allevents),
        const SizedBox(height: 50),
        Container(
          margin: const EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, NewEventView.route),
            child: const Row(
              children: [
                Icon(
                  Icons.diversity_3,
                  size: 30,
                ),
                Text('     Novo evento'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTabColumnWidget(String name, IconData icon) => Column(
        children: [Text(name), Icon(icon)],
      );

  Widget buildDescription(BuildContext context, String name, String descricao) => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            height: 100,
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
              // TO-DO! // EXIBIR CATEGORIAS
            ),
          )
        ],
      );
}
