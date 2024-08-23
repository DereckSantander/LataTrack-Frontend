import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latatrack/views/screens/main_screen.dart';
import 'package:latatrack/views/screens/stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index == 0 ? const MainScreen() : const StatsScreen(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: const Color.fromARGB(188, 192, 213, 195),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.house_fill,
                color: index == 0
                    ? const Color.fromARGB(255, 56, 136, 62)
                    : Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.graph_square_fill,
                color: index == 1
                    ? const Color.fromARGB(255, 56, 136, 62)
                    : Colors.grey,
              ),
              label: 'Stats',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
