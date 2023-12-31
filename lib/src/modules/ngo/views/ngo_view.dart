import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_events_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_home_view.dart';

class NgoView extends StatefulWidget {
  const NgoView({super.key});

  static String route = 'ngo-initial-view';

  @override
  State<NgoView> createState() => _NgoViewState();
}

class _NgoViewState extends State<NgoView> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    NgoHomeView(),
    NgoEventsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Eventos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
