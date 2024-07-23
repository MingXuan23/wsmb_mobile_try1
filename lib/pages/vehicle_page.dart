import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/models/driver.dart';
import 'package:wsmb_day1_try1/models/vechicle.dart';
import 'package:wsmb_day1_try1/pages/create_vehicle_page.dart';
import 'package:wsmb_day1_try1/services/firestore_service.dart';
import 'package:wsmb_day1_try1/widgets/vehicle_card.dart';

class VehicleTabPage extends StatelessWidget {
  const VehicleTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => VehiclePage()),
    );
  }
}

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  List<Vehicle> list = [];
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
    list = await FirestoreService.getVehicle(token);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var filterList = list
        .where((e) =>
            e.car_model.toLowerCase().contains(keyword.toLowerCase()) ||
            e.capacity.toString().contains(keyword.toLowerCase()) ||
            e.special_feature.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    return Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: SearchController,
              decoration: InputDecoration(labelText: 'Search Vehicle'),
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
                  return VehicleCard(
                    vehicle: filterList[index],
                    func: getVehicleList,
                  );
                },
              ),
            ),
            SizedBox(height: 80,)
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: IconButton(
              color: Colors.primaries[4],
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateVehiclePage()));
                getVehicleList();
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
