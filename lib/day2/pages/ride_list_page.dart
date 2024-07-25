import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/day2/models/ride.dart';
import 'package:wsmb_day1_try1/day2/services/database_service.dart';
import 'package:wsmb_day1_try1/day2/widgets/rideCard.dart';

class RideListMainPage extends StatelessWidget {
  const RideListMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => RideListPage()),
    );
  }
}

class RideListPage extends StatefulWidget {
  const RideListPage({super.key});

  @override
  State<RideListPage> createState() => _RideListPageState();
}

class _RideListPageState extends State<RideListPage> {
  List<Ride> rideList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRideList();
  }

  void getRideList() async {
    rideList = await DatabaseService.getRideList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

        return  Expanded(
          child: ListView.builder(itemCount: rideList.length, itemBuilder: (context, index) {
            return RideCard(ride: rideList[index],func: getRideList,);
          }),
       
    );
  }
}
