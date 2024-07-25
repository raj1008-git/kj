class Event {
  final String poster;
  final String title;
  final String place;
  final String date;
  final String eventDetails;
  bool isFavorite;

  Event({
    required this.poster,
    required this.title,
    required this.place,
    required this.date,
    required this.eventDetails,
    this.isFavorite = false,
  });
}
