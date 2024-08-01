import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite_demo/features/home/services/db_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'SQFlite Database',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              child: const Text("Insert"),
              onPressed: () async {
                await DbHandler().insertData();
              }),
          ElevatedButton(
              child: const Text("Read"),
              onPressed: () async {
                var data = await DbHandler().readData();
                log("Read Data: $data");
              }),
        ],
      )),
    );
  }
}
