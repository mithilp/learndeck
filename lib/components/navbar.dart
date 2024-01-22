import 'package:flutter/material.dart';
import 'package:sample/screens/course_gen/title.dart';
import 'package:sample/screens/home.dart';
import 'package:sample/screens/library.dart';
import 'package:sample/utils/models/user.dart';

class NavBar extends StatefulWidget {
  final User user;
  int index;
  NavBar({super.key, required this.user, required this.index});
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int index = widget.index;

  late final List<Widget> _content = <Widget>[
    Home(user: widget.user),
    LibraryPage(user: widget.user),
    TitleScreen(user: widget.user, firstTime: false),
    LibraryPage(user: widget.user),
    Home(user: widget.user)
  ];

  void _onItemTapped(int indexTmp) {
    print(widget.user.username);

    setState(() {
      index = indexTmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _content.elementAt(index),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xff888888), width: 1.0))),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          backgroundColor: const Color(0x0fffffff),
          unselectedItemColor: const Color(0xff888888),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.add_circle_outline,
              ),
              label: 'New',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border),
              label: 'Starred',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
          currentIndex: index,
          selectedItemColor: const Color(0xff00b388),
          selectedIconTheme: const IconThemeData(size: 28),
          selectedFontSize: 14,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}