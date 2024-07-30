class Event {
  final String documentId; // Add this field
  final String poster;
  final String title;
  final String place;
  final String date;
  final String eventDetails;
  bool isFavorite;
  final String? organizerId;
  var ticketPrice;

  Event({
    required this.documentId, // Add this parameter
    required this.poster,
    required this.title,
    required this.place,
    required this.date,
    required this.eventDetails,
    this.isFavorite = false,
    required this.organizerId,
    required this.ticketPrice,
  });

  factory Event.fromFirestore(String documentId, Map<String, dynamic> data) {
    return Event(
      documentId: documentId, // Initialize the documentId
      poster: data['posterImage'] ?? '',
      title: data['title'] ?? 'No Title',
      place: data['place'] ?? 'Unknown Place',
      date: data['date'] ?? 'No Date',
      eventDetails: data['details'] ?? 'No Details',
      organizerId: data['organizerId'] ?? '',
      ticketPrice: data['ticketPrice'] ?? '',
    );
  }
}
