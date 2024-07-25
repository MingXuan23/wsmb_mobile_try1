
import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/day2/models/rider.dart';
import 'package:wsmb_day1_try1/day2/pages/ride_list_page.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key, required this.rider});

  final Rider rider;

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {

  List<Widget> tabs = [];
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
              Text('KONGSI KERETA for rider'),
              GestureDetector(
                onTap: (){
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfilePage()));
                },
                child: CircleAvatar(
                  backgroundImage: (widget.rider.photo !=null)?NetworkImage(widget.rider.photo!):null,
                  backgroundColor: Colors.purple,
                  radius: 30.0,
                  
                ),
              )
            ],
          ),
          
        ),
        body: RideListMainPage(),
      //   bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //        currentIndex =index;
      //     });
        
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.car_rental_rounded), label: 'Vehicle'),
      //     BottomNavigationBarItem(icon: Icon(Icons.article), label: "Ride"),
        
      //   ],
      // ),
      ),
    );
  }
}
