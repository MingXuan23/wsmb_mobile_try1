

import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  final DateTime date;
  final String origin;
  final String destination;
  final double fare;
  final String vehicle_id;
  String status;
  String? id;
  List<String>? riderIds =[];
  List<DocumentReference>? riders = [];
  

  Ride(
      {this.id,
       this.riderIds,
       this.riders,
      required this.status,
      required this.date,
      required this.origin,
      required this.destination,
      required this.fare,
      required this.vehicle_id});

  factory Ride.fromJson(Map<String, dynamic> json, String rid) {
    var id = json['riderIds'] as List;
    var newids = id.map((x) => x.toString()).toList() as List<String>;

     var ref = json['riders'] as List;
    var refList = ref.map((x) => x as DocumentReference).toList() as List<DocumentReference>;
    
    return Ride(
      id: rid,
      date: DateTime.parse(json['date']),
      origin: json['origin'] ?? '',
      destination: json['destination'] ?? '',
      vehicle_id: json['vehicle_id'] ?? '',
      fare: json['fare'] as double,
      status: json['status']??'Cancelled',
      riderIds: newids,
      riders: refList
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
      'riderIds':riderIds??[],
      'riders':riders??[]
    };
  }
}
