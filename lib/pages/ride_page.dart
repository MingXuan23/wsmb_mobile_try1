import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/models/driver.dart';
import 'package:wsmb_day1_try1/models/ride.dart';
import 'package:wsmb_day1_try1/models/vechicle.dart';
import 'package:wsmb_day1_try1/pages/create_ride_page.dart';
import 'package:wsmb_day1_try1/services/firestore_service.dart';
import 'package:wsmb_day1_try1/widgets/ride_card.dart';

class RideTabPage extends StatelessWidget {
  const RideTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => RidePage()),
    );
  }
}

class RidePage extends StatefulWidget {
  const RidePage({super.key});

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  List<Ride> list = [];
  List<Vehicle> vehicleList = [];

  String keyword = '';
  final SearchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVehicleList();

  }

  void getVehicleList() async {
    var token = await Driver.getToken();
    vehicleList = await FirestoreService.getVehicle(token);

    list= await FirestoreService.getRide(token);
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    var filterList = list
        .where((e) =>
            e.destination.toLowerCase().contains(keyword.toLowerCase()) ||
            e.origin.toString().contains(keyword.toLowerCase()))
        .toList();
    return Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: SearchController,
              decoration: InputDecoration(labelText: 'Search Ride'),
              onChanged: (value) {
                setState(() {
                  keyword = value.trim();
                  // Add logic to filter the list based on the keyword
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filterList.length,
                itemBuilder: (context, index) {
                  return RideCard(
                    ride: filterList[index],
                    func: getVehicleList,
                  );
                },
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: IconButton(
              color: Colors.primaries[4],
              onPressed: () async {
                if (vehicleList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Add vehicle first')));
                  return;
                }
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateRidePage(
                          vehicleList: vehicleList,
                        )));
              },
              icon: Icon(Icons.add_circle_rounded),
              iconSize: 60,
            ),
          ),
        ),
      ],
    );
  }
}
