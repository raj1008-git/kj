import 'package:flutter/material.dart';

import '../EventModel/event_model.dart';

class EventProvider with ChangeNotifier {
  List<Event> _savedEvents = [];

  List<Event> get savedEvents => _savedEvents;

  void toggleFavorite(Event event) {
    event.isFavorite = !event.isFavorite;
    if (event.isFavorite) {
      _savedEvents.add(event);
    } else {
      _savedEvents.removeWhere((e) => e.title == event.title);
    }
    notifyListeners();
  }
}
