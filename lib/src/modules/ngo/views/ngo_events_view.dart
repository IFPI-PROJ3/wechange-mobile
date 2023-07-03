import 'package:flutter/material.dart';

class NgoEventsView extends StatefulWidget {
  const NgoEventsView({super.key});

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
              //Tab(text: 'Alertas', icon: Icon(Icons.campaign)),
              Tab(text: 'Ativos', icon: Icon(Icons.diversity_3_sharp)),
              Tab(text: 'Em breve', icon: Icon(Icons.diversity_3_outlined)),
              Tab(text: 'Finalizados', icon: Icon(Icons.close))
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            //Center(child: Text("Alertas")),
            Center(
              child: Text("Ativos"),
            ),
            Center(
              child: Text("Em breve"),
            ),
            Center(
              child: Text("Finalizados"),
            ),
          ],
        ),
      ),
    );
  }
}
