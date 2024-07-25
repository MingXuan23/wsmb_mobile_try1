

class Ride {
  final DateTime date;
  final String origin;
  final String destination;
  final double fare;
  final String vehicle_id;
  String status;
  String? id;

  Ride(
      {this.id,
      required this.status,
      required this.date,
      required this.origin,
      required this.destination,
      required this.fare,
      required this.vehicle_id});

  factory Ride.fromJson(Map<String, dynamic> json, String rid) {
    return Ride(
      id: rid,
      date: DateTime.parse(json['date']),
      origin: json['origin'] ?? '',
      destination: json['destination'] ?? '',
      vehicle_id: json['vehicle_id'] ?? '',
      fare: json['fare'] as double,
      status: json['status']??'Cancelled'
    );
  }

  toJson() {
    return {
      'id': id,
      'vehicle_id': vehicle_id,
      'fare': fare,
      'destination': destination,
      'origin': origin,
      'date': date.toString(),
      'status':status,
    };
  }
}
