import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/models/driver.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final icnoController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();


  Future<void> login() async{
    if(formkey.currentState!.validate()){
      var driver = await Driver.login(icnoController.text, passwordController.text);
      if(driver == null){
          await showDialog(context: context, builder: (context)=> AlertDialog(
                title: Text('Warning'),
                content: Text('Invalid Login'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ));
          return;
      }else{
        await showDialog(context: context, builder: (context)=> AlertDialog(
                title: Text('Success'),
                content: Text('Login Successful'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ));
          Navigator.of(context).pop();
      }
    }
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Driver Log In'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: formkey,
              child: Wrap(
                spacing: 30,
                children: [
                  TextFormField(
                    controller: icnoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your IC Number';
                      } else if (value.length != 12 ||
                          int.tryParse(value) == null) {
                        return 'Please enter valid ic number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.primaries[4]),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.primaries[4]),
                      onPressed:login,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
