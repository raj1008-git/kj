// import 'package:flutter/material.dart';
//
// import 'EventModel/event_model.dart';
// import 'Screens/BookingsScreen/booking_screen.dart';
// import 'Screens/ExploreScreen/explore_screen.dart';
// import 'Screens/HomeScreen/home_screen.dart';
// import 'Screens/SavedScreen/saved_screen.dart';
// import 'Screens/SettingsScreen/settings_screen.dart';
//
// class MainScaffold extends StatefulWidget {
//   Event? event;
//   int selectedIndex = 0;
//   MainScaffold({super.key, required this.selectedIndex, this.event});
//
//   @override
//   _MainScaffoldState createState() => _MainScaffoldState();
// }
//
// class _MainScaffoldState extends State<MainScaffold> {
//   @override
//   Widget build(BuildContext context) {
//     final screens = [
//       HomeScreen(),
//       ExploreScreen(),
//       BookingsScreen(),
//       SavedScreen(),
//       SettingsScreen(),
//     ];
//     return Scaffold(
//       appBar: widget.selectedIndex == 4
//           ? AppBar(
//               backgroundColor: Colors.black,
//               elevation: 0,
//               toolbarHeight: 70,
//               leading: null,
//               title: const Center(
//                 child: Text(
//                   'Settings',
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//               ),
//             )
//           : AppBar(
//               leading: null,
//               elevation: 0,
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     child: Image.asset(
//                       'assets/logos/kata_jane_main_logo.png',
//                       height: 120,
//                       width: 120,
//                       colorBlendMode: BlendMode.src, // Preserve original colors
//                     ),
//                   ),
//                   const Row(
//                     children: [
//                       Icon(
//                         Icons.search,
//                         color: Colors.white70,
//                         size: 30,
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Icon(
//                         Icons.notification_add_outlined,
//                         color: Colors.white70,
//                         size: 30,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               toolbarHeight: 70,
//               backgroundColor: Colors.black54,
//             ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.red, // Color for selected item label
//         unselectedItemColor: Colors.grey, // Color for unselected items labels
//
//         unselectedLabelStyle: const TextStyle(color: Colors.grey),
//         selectedLabelStyle: const TextStyle(color: Colors.red),
//         elevation: 0,
//         backgroundColor: Colors.white60,
//         currentIndex: widget.selectedIndex,
//         onTap: (index) => setState(() {
//           widget.selectedIndex = index;
//         }),
//         // selectedItemColor: Colors.red,
//         // unselectedItemColor: Colors.grey,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             label: 'Home',
//             backgroundColor: Colors.black54,
//             icon: Icon(
//               Icons.home_outlined,
//               color: widget.selectedIndex == 0 ? Colors.red : Colors.grey,
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.explore_outlined,
//               color: widget.selectedIndex == 1 ? Colors.red : Colors.grey,
//             ),
//             label: 'Explore',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.confirmation_num_outlined,
//               color: widget.selectedIndex == 2 ? Colors.red : Colors.grey,
//             ),
//             label: 'Bookings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.favorite_border,
//               color: widget.selectedIndex == 3 ? Colors.red : Colors.grey,
//             ),
//             label: 'Saved',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.settings_outlined,
//               color: widget.selectedIndex == 4 ? Colors.red : Colors.grey,
//             ),
//             label: 'Settings',
//           ),
//         ],
//       ),
//       backgroundColor: Colors.black54,
//       body: screens[widget.selectedIndex],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'EventModel/event_model.dart';
import 'Screens/BookingsScreen/booking_screen.dart';
import 'Screens/ExploreScreen/explore_screen.dart';
import 'Screens/HomeScreen/home_screen.dart';
import 'Screens/SavedScreen/saved_screen.dart';
import 'Screens/SettingsScreen/settings_screen.dart';

class MainScaffold extends StatefulWidget {
  final Event? event;
  int selectedIndex;
  MainScaffold({super.key, required this.selectedIndex, this.event});

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  bool _showNotifications = false;
  int _unreadNotifications = 0;
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchUnreadNotifications();
  }

  Future<void> _fetchUnreadNotifications() async {
    // Fetch unread notifications count
    final notificationsSnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('status', isEqualTo: 'unread')
        .get();

    setState(() {
      _unreadNotifications = notificationsSnapshot.docs.length;
    });
  }

  Future<void> _fetchNotifications() async {
    final notificationsSnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .get();

    setState(() {
      _notifications =
          notificationsSnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  void _toggleNotifications() async {
    setState(() {
      _showNotifications = !_showNotifications;
    });

    if (_showNotifications) {
      await _fetchNotifications();
    }
  }

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
      appBar: widget.selectedIndex == 4
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
                  Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white70,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Stack(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.white70,
                              size: 30,
                            ),
                            onPressed: _toggleNotifications,
                          ),
                          if (_unreadNotifications > 0)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: 16,
                                  maxHeight: 16,
                                ),
                                child: Center(
                                  child: Text(
                                    '$_unreadNotifications',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
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
        currentIndex: widget.selectedIndex,
        onTap: (index) => setState(() {
          widget.selectedIndex = index;
        }),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            backgroundColor: Colors.black54,
            icon: Icon(
              Icons.home_outlined,
              color: widget.selectedIndex == 0 ? Colors.red : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore_outlined,
              color: widget.selectedIndex == 1 ? Colors.red : Colors.grey,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.confirmation_num_outlined,
              color: widget.selectedIndex == 2 ? Colors.red : Colors.grey,
            ),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              color: widget.selectedIndex == 3 ? Colors.red : Colors.grey,
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              color: widget.selectedIndex == 4 ? Colors.red : Colors.grey,
            ),
            label: 'Settings',
          ),
        ],
      ),
      backgroundColor: Colors.black54,
      body: Stack(
        children: [
          screens[widget.selectedIndex],
          if (_showNotifications)
            Positioned(
              // top: AppBar().preferredSize.height,
              right: 0,
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];
                    return ListTile(
                      leading: notification['posterImage'],
                      title: Text(
                        notification['title'],
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Text(
                        notification['date'],
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      child: Divider(
                        color: Colors.pink,
                      ),
                      height: 5,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
