import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/models/vechicle.dart';
import 'package:wsmb_day1_try1/pages/edit_vehicle_page.dart';
import 'package:wsmb_day1_try1/services/firestore_service.dart';

class VehicleCard extends StatefulWidget {
  const VehicleCard({super.key, required this.vehicle, required this.func});

  final Vehicle vehicle;
  final Function func;
  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  @override
  Widget build(BuildContext context) {
    var imageLink = widget.vehicle.image == '' ? null : widget.vehicle.image;

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
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.width * 0.25,
            child: Image.network(
              imageLink ??
                  'https://firebasestorage.googleapis.com/v0/b/wsmb-try1.appspot.com/o/vehicle%2F1721706260095.jpg?alt=media&token=9b331ad6-2781-4ecc-9c04-be4884005184',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Car Models: ${widget.vehicle.car_model}',
                ),
                Text('Capacity: ${widget.vehicle.capacity}'),
                Text('Special Features: ${widget.vehicle.special_feature}'),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditVehiclePage(vehicle: widget.vehicle,)));
                widget.func();
              }, child: Text('Edit')),
              MaterialButton(
                onPressed: () async {
                  await FirestoreService.deleteVehicle(widget.vehicle.id ?? '');
                  widget.func();
                },
                child: Text('Delete'),
              )
            ],
          )
        ],
      ),
    );
  }
}
