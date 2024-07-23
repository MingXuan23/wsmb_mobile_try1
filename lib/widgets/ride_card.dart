import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/models/ride.dart';

import 'package:wsmb_day1_try1/services/firestore_service.dart';

class RideCard extends StatefulWidget {
  const RideCard({super.key, required this.ride, required this.func});

  final Ride ride;
  final Function func;
  @override
  State<RideCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<RideCard> {
  @override
  Widget build(BuildContext context) {
    

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      height: MediaQuery.of(context).size.height * 0.20,
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Origin: ${widget.ride.origin}',
                ),
                Text('Destination: ${widget.ride.destination}'),
                Text('Fare: RM ${widget.ride.fare.toStringAsFixed(2)}'),
                Text('Date time: ${widget.ride.date.toString().replaceRange(16, null, '')}'),
                Text('Status: ${widget.ride.status}')
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.ride.status == 'OK')
              MaterialButton(
                onPressed: () async {
                
                  widget.func();
                },
                child: Text('Cancel'),
              )
            ],
          )
        ],
      ),
    );
  }
}
