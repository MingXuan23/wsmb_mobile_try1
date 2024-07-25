import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/day1/models/ride.dart';
import 'package:wsmb_day1_try1/day1/models/vechicle.dart';
import 'package:wsmb_day1_try1/day1/services/firestore_service.dart';

class CreateRidePage extends StatefulWidget {
  const CreateRidePage({super.key, required this.vehicleList});
  final List<Vehicle> vehicleList;
  @override
  State<CreateRidePage> createState() => _CreateRidePageState();
}

class _CreateRidePageState extends State<CreateRidePage> {
  final originController = TextEditingController();
  final destController = TextEditingController();

  final fareController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime datetime = DateTime.now();
  String vechicle_id = '';

  void submitForm() async {
    if (datetime.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Date')));

      return;
    }
    if (formKey.currentState!.validate()) {
      Ride ride = Ride(
          status: 'OK',
          date: datetime,
          origin: originController.text,
          destination: destController.text,
          fare: double.parse(fareController.text),
          vehicle_id: vechicle_id);

      var res = await FirestoreService.addRide(ride);
      if (res) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
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

  void takeDateTime() async {
    var tempdate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)));
    if (tempdate == null) {
      return;
    }

    datetime = tempdate;

    var tempTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: DateTime.now().hour, minute: DateTime.now().minute));
    if (tempTime == null) {
      return;
    }

    datetime = DateTime(datetime.year, datetime.month, datetime.day,
        tempTime.hour, tempTime.minute);

    if (datetime.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Date')));

      return;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    vechicle_id = widget.vehicleList[0].id!;
    super.initState();
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
                controller: originController,
                decoration: InputDecoration(label: Text('Origin')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter origin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: destController,
                decoration: InputDecoration(label: Text('Destination')),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter destination';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: fareController,
                decoration: InputDecoration(label: Text('Fare')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Fare';
                  } else if (double.tryParse(value) == null) {
                    return 'Please enter valid fare';
                  }
                  return null;
                },
              ),
              Text(datetime.toString().replaceRange(16, null, '')),
              DropdownButton(
                  items: [
                    for (int i = 0; i < widget.vehicleList.length; i++)
                      DropdownMenuItem(
                        child: Text(
                          widget.vehicleList[i].car_model,
                        ),
                        value: widget.vehicleList[i].id,
                      )
                  ],
                  value: vechicle_id,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    vechicle_id = value;
                    setState(() {});
                  }),
              Row(
                children: [
                  TextButton(onPressed: takeDateTime, child: Text('DateTime')),
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
