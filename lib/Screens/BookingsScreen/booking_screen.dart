import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kata_jane/Screens/AuthenticationScreen/login_screen.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';

import '../../EventModel/event_model.dart';
import '../../Functions/authFunctions.dart';

class BookingsScreen extends StatefulWidget {
  final Event? event;
  BookingsScreen({Key? key, this.event}) : super(key: key);

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  List<Map<String, dynamic>> _bookedEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchBookedEvents();
  }

  Future<void> _fetchBookedEvents() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    if (authService.user == null) return;

    String userId = authService.userId!;

    // Fetch tickets for the current user
    QuerySnapshot ticketSnapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .where('userId', isEqualTo: userId)
        .get();

    List<Map<String, dynamic>> bookedEvents = [];

    for (var ticketDoc in ticketSnapshot.docs) {
      Map<String, dynamic> ticketData =
          ticketDoc.data() as Map<String, dynamic>;

      // Fetch the event details using the eventId from the ticket
      DocumentSnapshot eventDoc = await FirebaseFirestore.instance
          .collection('events')
          .doc(ticketData['eventId'])
          .get();

      if (eventDoc.exists) {
        Map<String, dynamic> eventData =
            eventDoc.data() as Map<String, dynamic>;
        eventData['ticketNumber'] = ticketData['ticketNumber'];
        eventData['eventId'] =
            ticketData['eventId']; // Add eventId to eventData
        bookedEvents.add(eventData);
      }
    }

    setState(() {
      _bookedEvents = bookedEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    if (authService.user == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Not Logged in yet 😂',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 130),
                color: Colors.pink,
                onPressed: () async {
                  if (authService.user == null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    await authService.logout(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                child: Text(
                  'Login',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 0, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _bookedEvents.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> event = _bookedEvents[index];
                    return GestureDetector(
                      onTap: () => _showEventDetails(event),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 90,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                    image: NetworkImage(event['posterImage']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      event['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      event['date'],
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Text(
                                          event['place'],
                                          style: const TextStyle(
                                            color: Colors.white54,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Icon(
                                          size: 20,
                                          Icons.location_pin,
                                          color: Colors.white54,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            event['title'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Event ID: ${event['eventId']}',
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.brown, // Event ID color
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Ticket Number: ${event['ticketNumber']}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.green, // Ticket Number color
                ),
              ),
              SizedBox(
                height: 8,
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${event['date']}',
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Details: ${event['eventDetails']}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Place: ${event['place']}',
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  onPressed: () async {
                    final place = event['place'];

                    // Get the coordinates for the place
                    List<Location> locations = await locationFromAddress(place);
                    if (locations.isNotEmpty) {
                      final coords = Coords(
                        locations.first.latitude,
                        locations.first.longitude,
                      );

                      final availableMaps = await MapLauncher.installedMaps;

                      if (availableMaps.isNotEmpty) {
                        await availableMaps.first.showMarker(
                          coords: coords,
                          title: event['title'],
                          description: event['eventDetails'],
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No map apps installed.')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not find location.')),
                      );
                    }
                  },
                  child: const Text(
                    'Locate In Maps',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
