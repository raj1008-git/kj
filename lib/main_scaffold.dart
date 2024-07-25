import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/BookingsScreen/booking_screen.dart';
import 'Screens/ExploreScreen/explore_screen.dart';
import 'Screens/SavedScreen/saved_screen.dart';
import 'Screens/SettingsScreen/settings_screen.dart';

import 'Screens/HomeScreen/home_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(),
      ExploreScreen(),
      BookingsScreen(),
      SavedScreen(),
      SettingsScreen(),
    ];
    return Scaffold(
      appBar: _selectedIndex == 4
          ? AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              toolbarHeight: 70,
              leading: null,
              title: const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            )
          : AppBar(
              leading: null,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/logos/kata_jane_main_logo.png',
                      height: 120,
                      width: 120,
                      colorBlendMode: BlendMode.src, // Preserve original colors
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white70,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.notification_add_outlined,
                        color: Colors.white70,
                        size: 30,
                      ),
                    ],
                  )
                ],
              ),
              toolbarHeight: 70,
              backgroundColor: Colors.black54,
            ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red, // Color for selected item label
        unselectedItemColor: Colors.grey, // Color for unselected items labels

        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        selectedLabelStyle: const TextStyle(color: Colors.red),
        elevation: 0,
        backgroundColor: Colors.white60,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        // selectedItemColor: Colors.red,
        // unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            backgroundColor: Colors.black54,
            icon: Icon(
              Icons.home_outlined,
              color: _selectedIndex == 0 ? Colors.red : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore_outlined,
              color: _selectedIndex == 1 ? Colors.red : Colors.grey,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.confirmation_num_outlined,
              color: _selectedIndex == 2 ? Colors.red : Colors.grey,
            ),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              color: _selectedIndex == 3 ? Colors.red : Colors.grey,
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              color: _selectedIndex == 4 ? Colors.red : Colors.grey,
            ),
            label: 'Settings',
          ),
        ],
      ),
      backgroundColor: Colors.black54,
      body: screens[_selectedIndex],
    );
  }
}
