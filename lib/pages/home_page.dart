

import 'package:flutter/material.dart';
import 'package:wsmb_day1_try1/models/driver.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.driver});

  final Driver driver;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}