import 'package:flutter/material.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_home_view.dart';
import 'package:wechange_mobile/src/modules/ngo/views/ngo_profile_view.dart';

class NgoView extends StatefulWidget {
  const NgoView({super.key});

  @override
  State<NgoView> createState() => _NgoViewState();
}

class _NgoViewState extends State<NgoView> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    NgoHomeView(),
    Text(
      'Index 1: Eventos',
      //style: optionStyle,
    ),
    NgoProfileView()
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
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}
