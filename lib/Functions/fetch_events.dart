import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kata_jane/EventModel/event_model.dart';

Future<List<Event>> fetchEvents() async {
  final List<Event> events = [];
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('events').get();

  for (var doc in querySnapshot.docs) {
    final data = doc.data() as Map<String, dynamic>;
    final event = Event.fromFirestore(doc.id, data); // Pass document ID
    events.add(event);
  }

  return events;
}
