import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kata_jane/Functions/Api/esewa_payment.dart';
import 'package:provider/provider.dart';

import '../../../EventModel/event_model.dart';
import '../../../Functions/authFunctions.dart';
import '../../../Provider/event_provider.dart';
import '../../AuthenticationScreen/login_screen.dart';

class BookNow extends StatefulWidget {
  final Event event;

  BookNow({Key? key, required this.event}) : super(key: key);

  @override
  State<BookNow> createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  late EsewaService esewaService;

  @override
  void initState() {
    super.initState();
    esewaService = EsewaService(event: widget.event);
  }

  Future<void> _handleFavorite() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    if (authService.user == null) {
      // Redirect to login if not logged in
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else if (await _isUserAttendee(authService.userId!)) {
      final userId = authService.userId!;
      final eventId = widget.event.documentId;

      eventProvider.toggleFavorite(widget.event);

      // Update Firebase
      if (widget.event.isFavorite) {
        await FirebaseFirestore.instance
            .collection('favourites')
            .doc(userId)
            .set({
          eventId: true,
        }, SetOptions(merge: true)); // Use merge to keep existing data
      } else {
        await FirebaseFirestore.instance
            .collection('favourites')
            .doc(userId)
            .update({
          eventId: FieldValue.delete(), // Remove the event ID from favorites
        });
      }
    } else {
      // Redirect to login if user is not an attendee
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  Future<void> _handleBookNow() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    if (authService.user == null ||
        !(await _isUserAttendee(authService.userId!))) {
      // Redirect to login if not logged in or not an attendee
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      // Perform the booking action
      esewaService.useEsewa(context);
    }
  }

  Future<bool> _isUserAttendee(String userId) async {
    final attendeeDoc = await FirebaseFirestore.instance
        .collection('attendees')
        .doc(userId)
        .get();
    return attendeeDoc.exists;
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Container(
          color: Colors.black12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                height: 5,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Starting from Rs. ${widget.event.ticketPrice}',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: _handleBookNow,
                      color: Colors.green,
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 150,
                        color: Colors.blueAccent,
                      ),
                      Container(
                        height: 250,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10,
                    left: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: NetworkImage(widget.event.poster),
                            fit: BoxFit.fill),
                      ),
                      width: 370,
                      height: 370,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.event.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Consumer<EventProvider>(
                          builder: (context, eventProvider, child) {
                            return IconButton(
                              icon: Icon(
                                widget.event.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: widget.event.isFavorite
                                    ? Colors.red
                                    : Colors.white,
                                size: 30,
                              ),
                              onPressed: _handleFavorite,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.red,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.event.date,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.event.place,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Event Details',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Container(
                          width: 200,
                          height: 4,
                          color: Colors.red,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.event.eventDetails,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'Terms & Conditions',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 200,
                            height: 4,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1. Tickets are Non-Refundable',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '2. Illegal substances and sharp objects are not allowed inside the venue',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '3. Organizers, venues, artists, and affiliates are not liable for any personal injury, loss, or damage to personal belongings during the event',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
