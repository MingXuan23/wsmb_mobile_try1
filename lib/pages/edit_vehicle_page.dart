import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wsmb_day1_try1/models/vechicle.dart';
import 'package:wsmb_day1_try1/services/firestore_service.dart';
import 'package:wsmb_day1_try1/widgets/pickerSheet.dart';

class EditVehiclePage extends StatefulWidget {
  const EditVehiclePage({super.key, required this.vehicle});

  final Vehicle vehicle;
  @override
  State<EditVehiclePage> createState() => _CreateVeheclePageState();
}

class _CreateVeheclePageState extends State<EditVehiclePage> {
  final modelController = TextEditingController();
  final capacityController = TextEditingController();

  final featureController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Image? oldImage;
  File? image;

  void submitForm() async {

    if(image!=null){
      widget.vehicle.image = await Vehicle.saveImage(image!);
    }

    if (formKey.currentState!.validate()) {
      Vehicle v = Vehicle(
          car_model: modelController.text,
          capacity: int.parse(capacityController.text),
          driver_id: widget.vehicle.driver_id,
          special_feature: featureController.text,
          image: widget.vehicle.image,

          );

      var res = await FirestoreService.updateVehicle(v, widget.vehicle.id!);
      if (res) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Success'),
                  content: Text('Your vehicle is edit successfully'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
                  ],
                ));
        Navigator.of(context).pop();
      } else {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
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
    featureController.text = widget.vehicle.special_feature;
    modelController.text = widget.vehicle.car_model;

    capacityController.text = widget.vehicle.capacity.toString();
    if (widget.vehicle.image != null || widget.vehicle.image != '') {
      oldImage = Image.network(widget.vehicle.image!);
    }
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
              Container(
                  height: 200,
                  width: double.infinity,
                  child: (image != null)
                      ? Image.file(image!)
                      : (oldImage != null)
                          ? oldImage
                          : Container()),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        takePhoto(context);
                      },
                      child: Text('Take Photo')),
                  TextButton(onPressed: submitForm, child: Text('Submit'))
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
