import 'package:flutter/material.dart';

class BotonNav extends StatefulWidget {
  final Function currentIndex;
  const BotonNav({Key? key, required this.currentIndex}) : super(key: key);
  @override
  State<BotonNav> createState() => _BotonNavState();
}

class _BotonNavState extends State<BotonNav> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int i) {
        setState(() {
          index = i;
          widget.currentIndex(i);
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue[900],
      iconSize: 25.0,
      selectedFontSize: 14.0,
      unselectedFontSize: 12.0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted_outlined),
          label: 'Listado',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money_outlined),
          label: 'Productos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_accessibility),
          label: 'Ajustes',
        ),
      ],
    );
  }
}
