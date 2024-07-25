

import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/day2/models/rider.dart';
import 'package:wsmb_day1_try1/day2/pages/home_page.dart';
import 'package:wsmb_day1_try1/day2/pages/login_page.dart';
import 'package:wsmb_day1_try1/day2/pages/register_page.dart';

class StartPage2 extends StatefulWidget {
  const StartPage2({super.key});

  @override
  State<StartPage2> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage2> {

  void redirectRegisterPage(){
    Navigator.of(context).push( MaterialPageRoute(builder: (context)=> const RegisterPage2() ));
  }

  void redirectLoginPage() async{
    await Navigator.of(context).push( MaterialPageRoute(builder: (context)=> const LoginPage2() ));
    signIn();
  }


  Future<void> signIn() async{
    var rider = await Rider.getRiderByToken();
    if(rider != null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage2(rider: rider)));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signIn();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Kongsi Kereta for Riders'),
          ElevatedButton(onPressed: redirectRegisterPage, child: Text('Register')),
          ElevatedButton(onPressed: redirectLoginPage, child: Text('Login')),
        
        ],),
      ),
    );
  }
}