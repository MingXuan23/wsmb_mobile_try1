import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wsmb_day1_try1/models/vechicle.dart';
import 'package:wsmb_day1_try1/widgets/pickerSheet.dart';

class CreateVehiclePage extends StatefulWidget {
  const CreateVehiclePage({super.key});

  @override
  State<CreateVehiclePage> createState() => _CreateVeheclePageState();
}

class _CreateVeheclePageState extends State<CreateVehiclePage> {
  final modelController = TextEditingController();
  final capacityController = TextEditingController();

  final featureController = TextEditingController();

  final formKey = GlobalKey<FormState>();


  File? image;
  void submitForm() async{

    if(formKey.currentState!.validate()){
      var res =  await Vehicle.registerVehicle(modelController.text,int.parse(capacityController.text) ,featureController.text, image);
     if(res){
         await showDialog(context: context, builder: (context)=> AlertDialog(
                title: Text('Success'),
                content: Text('Your vehicle is added successfully'),
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
     else{
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
     }
     
      
    }
    //Vehicle car = Vehicle(car_model: car_model, capacity: capacity, driver_id: driver_id, special_feature: special_feature)
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
  void initState() {
    // TODO: implement initState
    super.initState();
    featureController.text = 'None';
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
            child: Form(
              key: formKey,
          child: Wrap(
            children: [
              TextFormField(
                controller: modelController,
                decoration: InputDecoration(label: Text('Car Model')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter car model';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: capacityController,
                decoration: InputDecoration(label: Text('Capacity')),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter capacity';
                  } else if (int.tryParse(value) == null) {
                    return 'Please enter valid capacity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: featureController,
                decoration: InputDecoration(label: Text('Special Feature')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter car model';
                  }
                  return null;
                },
              ),
              Container(height: 200,width: double.infinity,child: (image !=null)?Image.file(image!):Container()),
              Row(children: [TextButton(onPressed: (){takePhoto(context);}, child: Text('Take Photo')) ,TextButton(onPressed: submitForm, child: Text('Submit'))],)
            ],
          ),
        )),
      ),
    );
  }
}
