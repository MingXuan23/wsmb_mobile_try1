import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/day1/models/driver.dart';
import 'package:wsmb_day1_try1/day1/pages/profile._page.dart';
import 'package:wsmb_day1_try1/day1/pages/ride_page.dart';
import 'package:wsmb_day1_try1/day1/pages/vehicle_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.driver});

  final Driver driver;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Widget> tabs = [VehicleTabPage(), RideTabPage()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          titleSpacing: 10.0,
          toolbarHeight: 60.0,
          title: Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('KONGSI KERETA'),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfilePage()));
                },
                child: CircleAvatar(
                  backgroundImage: (widget.driver.photo !=null)?NetworkImage(widget.driver.photo!):null,
                  backgroundColor: Colors.purple,
                  radius: 30.0,
                  
                ),
              )
            ],
          ),
          
        ),
        body: IndexedStack(children: tabs , index: currentIndex,),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
             currentIndex =index;
          });
        
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.car_rental_rounded), label: 'Vehicle'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Ride"),
        
        ],
      ),
      ),
    );
  }
}
