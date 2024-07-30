import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kata_jane/main_scaffold.dart';
import 'package:provider/provider.dart';

import '../../Functions/authFunctions.dart';
import 'create_event.dart';

// Import the create event page

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        title: Expanded(
          child: Center(
            child: Row(
              children: [
                SizedBox(
                  width: 55,
                ),
                const Text(
                  'Organizer ',
                  style: TextStyle(color: Colors.teal, fontSize: 35),
                ),
                Text(
                  ' Services',
                  style: TextStyle(color: Colors.blue, fontSize: 35),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Color.fromRGBO(229, 183, 186, 1),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                onPressed: () {
                  if (user != null) {
                    // Pass the organizer ID to the CreateEventPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CreateEventPage(organizerId: user.uid),
                      ),
                    );
                  } else {
                    // Handle the case when the user is not logged in
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User is not logged in')),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Event',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.blue,
                      size: 60,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Color.fromRGBO(187, 186, 226, 1),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              onPressed: () {
                if (user != null) {
                  // Pass the organizer ID to the CreateEventPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateEventPage(organizerId: user.uid),
                    ),
                  );
                } else {
                  // Handle the case when the user is not logged in
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User is not logged in')),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Events',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  Icon(
                    Icons.event,
                    color: Colors.blue,
                    size: 60,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200,
            ),
            MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
              color: Colors.pink,
              child: GestureDetector(
                onTap: () async {
                  await authService.logout(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScaffold(selectedIndex: 0),
                    ),
                  );
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
