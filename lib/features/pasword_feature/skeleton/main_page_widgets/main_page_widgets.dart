import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramzino/core/utils/const.dart';
import 'package:ramzino/features/pasword_feature/presentation/pages/home_page.dart';

import '../../presentation/pages/passwords_page.dart';
import '../../presentation/pages/profile_page.dart';
import '../bloc/main_bloc.dart';

class BuildBottomNavigationBar extends StatefulWidget {
  const BuildBottomNavigationBar({required this.context});
  final BuildContext context;

  @override
  State<BuildBottomNavigationBar> createState() =>
      _BuildBottomNavigationBarState();
}

class _BuildBottomNavigationBarState extends State<BuildBottomNavigationBar> {
  bool _page1 = false;
  bool _page2 = false;
  bool _page3 = false;

  void _ontap(int index) {
    context.read<MainBloc>().add(Trigger(index));
    setState(() {
      switch (index) {
        case 0:
          {
            _page1 = true;
            _page2 = false;
            _page3 = false;
          }
        case 1:
          {
            _page1 = false;
            _page2 = true;
            _page3 = false;
          }
        case 2:
          {
            _page1 = false;
            _page2 = false;
            _page3 = true;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: _ontap,
        currentIndex: context.read<MainBloc>().state.index,
        elevation: 7,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: kbuttonColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey.shade400,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                _page1 ? Icons.home : Icons.home_outlined,
                size: 30,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                _page2 ? Icons.shield : Icons.shield_outlined,
                size: 29,
              ),
              label: 'Passwords'),
          BottomNavigationBarItem(
              icon: Icon(
                _page3 ? Icons.person : Icons.person_outline,
                size: 30,
              ),
              label: 'Profile')
        ]);
  }
}

Widget screens(int index) {
  List<Widget> screens = [
    const HomePage(),
    const PasswordsPage(),
    const ProfilePage(),
  ];
  return screens[index];
}
