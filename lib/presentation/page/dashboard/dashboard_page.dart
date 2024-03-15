// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:attendance/presentation/page/history/history_page.dart';
import 'package:flutter/material.dart';

import '../../../common/colors.dart';
import '../home/home_page.dart';
import '../setting/setting_page.dart';

class DashboardPage extends StatefulWidget {
  final int currentTab;
  const DashboardPage({
    super.key,
    required this.currentTab,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  late int _selectedIndex;
  final List<Widget> _pages = [
    const HomePage(),
    const HistoryPage(),
    const SettingPage()
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    _selectedIndex = widget.currentTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: AppColors.grey,
            ),
            activeIcon: Icon(
              Icons.home,
              color: AppColors.primary,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: AppColors.grey,
            ),
            activeIcon: Icon(
              Icons.people,
              color: AppColors.primary,
            ),
            label: 'HISTORY',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: AppColors.grey,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: AppColors.primary,
            ),
            label: 'SETTING',
          ),
        ],
      ),
    );
  }
}