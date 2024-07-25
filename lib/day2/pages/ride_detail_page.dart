import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/day1/models/driver.dart';
import 'package:wsmb_day1_try1/day2/models/ride.dart';
import 'package:wsmb_day1_try1/day1/models/vechicle.dart';
import 'package:wsmb_day1_try1/day2/models/rider.dart';
import 'package:wsmb_day1_try1/day2/services/database_service.dart';

class RideDetailPage extends StatefulWidget {
  const RideDetailPage({super.key, required this.ride});

  final Ride ride;

  @override
  State<RideDetailPage> createState() => _RideDetailPageState();
}

class _RideDetailPageState extends State<RideDetailPage> {
  Driver? driver;
  Vehicle? vehicle;
  Rider? rider;

  bool isJoin = false;
  void getDetail() async {
    var res = await DatabaseService.getRideDetails(widget.ride.id!);
    rider = await Rider.getRiderByToken();
    if (res.$1 == null || res.$2 == null || rider == null) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Warning'),
                content: Text('Something went wrong'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ));
      Navigator.of(context).pop();
      return;
    }

    driver = res.$2;
    vehicle = res.$1;

    isJoin = widget.ride.riderIds!.contains(rider?.id ?? '');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text(driver?.name ?? ''),
            Text(vehicle?.car_model ?? ''),
            Text(vehicle?.capacity.toString() ?? '0'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('return')),
            (isJoin)
                ? ElevatedButton(
                    onPressed: () async {
                      var res = await DatabaseService.cancelRide(
                          widget.ride, vehicle!, rider!);
                      if (res) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Cancal'))
                : ElevatedButton(
                    onPressed: () async {
                      var res = await DatabaseService.joinRide(
                          widget.ride, vehicle!, rider!);
                      if (res) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Join'))
          ],
        ),
      ),
    );
  }
}
