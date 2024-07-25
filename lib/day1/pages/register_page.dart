import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wsmb_day1_try1/day1/models/driver.dart';
import 'package:wsmb_day1_try1/day1/widgets/pickerSheet.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final icnoController = TextEditingController();

  final phoneController = TextEditingController();

  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  File? image;
  String gender = 'male';

  void genderChanged(String? value) {
    setState(() {
      gender = value!;
    });
  }

  void submitForm(BuildContext context) async {
    if (image == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Warning'),
                content: Text('Please upload your image'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ));
    }
    if (formkey.currentState!.validate()) {
      Driver tempDriver = Driver(
          email: emailController.text,
          address: addressController.text,
          gender: gender == 'male',
          icno: icnoController.text,
          name: nameController.text,
          phone: phoneController.text);
        
 
      var driver = await Driver.register(tempDriver, passwordController.text,image!);

      if(driver == null){
        await showDialog(context: context, builder: (context)=> AlertDialog(
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
          return;
      }else{
        await showDialog(context: context, builder: (context)=> AlertDialog(
                title: Text('Success'),
                content: Text('Your registration is success, pleas log in'),
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
      // 
    }
  }

  Future<void> takePhoto(BuildContext context) async {
    ImageSource? source = await showModalBottomSheet(
        context: context, builder: (context) => buildBottomSheet(context));

    if (source == null) {
      return;
    }

    ImagePicker picker = ImagePicker();
    var file = await picker.pickImage(source: source);
    if (file == null) {
      return;
    }

    image = File(file.path);
    setState(() {});


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  Row(
                    children: [
                      const Text('Gender'),
                      Radio(
                          value: 'male',
                          groupValue: gender,
                          onChanged: genderChanged),
                      Text('Male'),
                      Radio(
                          value: 'female',
                          groupValue: gender,
                          onChanged: genderChanged),
                      Text('Female'),
                    ],
                  ),
                  TextFormField(
                    controller: icnoController,
                    decoration: InputDecoration(labelText: 'IC Number'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ic number';
                      } else if (value.length != 12 ||
                          int.tryParse(value) == null) {
                        return 'Please enter valid ic number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (int.tryParse(value) == null) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (!value.contains('@')) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Please enter strong number';
                      }
                      return null;
                    },
                  ),
                  OutlinedButton(
                      onPressed: () {
                        takePhoto(context);
                      },
                      child: Expanded(
                          child: Container(
                        width: double.infinity,
                        child: Text('Take Photo'),
                      ))),
                  Container(
                      height: 100,
                      width: double.infinity,
                      child: (image != null)
                          ? Image.file(
                              image!,
                              fit: BoxFit.fitHeight,
                            )
                          : Container()),
                ],
              )),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.primaries[4]),
        height: MediaQuery.of(context).size.height * 0.1,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.primaries[4]),
          onPressed: () {
            submitForm(context);
          },
          child: Text(
            'Create Driver',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

