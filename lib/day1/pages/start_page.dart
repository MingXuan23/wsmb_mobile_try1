import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/day1/models/driver.dart';
import 'package:wsmb_day1_try1/day1/pages/home_page.dart';
import 'package:wsmb_day1_try1/day1/pages/login_page.dart';
import 'package:wsmb_day1_try1/day1/pages/register_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  void redirectRegisterPage(){
    Navigator.of(context).push( MaterialPageRoute(builder: (context)=> const RegisterPage() ));
  }

  void redirectLoginPage() async{
    await Navigator.of(context).push( MaterialPageRoute(builder: (context)=> const LoginPage() ));
    signIn();
  }


  Future<void> signIn() async{
    var driver = await Driver.getDriverByToken();
    if(driver != null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage(driver: driver)));
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
          Text('Kongsi Kereta'),
          ElevatedButton(onPressed: redirectRegisterPage, child: Text('Register')),
          ElevatedButton(onPressed: redirectLoginPage, child: Text('Login')),
        
        ],),
      ),
    );
  }
}