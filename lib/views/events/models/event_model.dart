class Event {
  final String eventName;
  final DateTime date;
  final String location;
  final String imageUrl;

  Event({
    required this.eventName,
    required this.date,
    required this.location,
    required this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventName: json['eventName'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      imageUrl: json['image'],
    );
  }
}