import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/day1/models/driver.dart';
import 'package:wsmb_day1_try1/day1/pages/start_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Log out'),
          onPressed: () async{
            await Driver.signOut();
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> StartPage()));
          },
        ),
      ),
    );
  }
}
