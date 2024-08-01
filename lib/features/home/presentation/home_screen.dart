import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite_demo/features/home/model/model_class.dart';
import 'package:sqflite_demo/features/home/presentation/data_screen.dart';
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
      //! Floating Action Button

      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.laptop),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DataScreen(),
                ));
          }),

      //! App Bar,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'SQFlite Database',
          style: TextStyle(color: Colors.white),
        ),
      ),

      //! Body,

      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              child: const Text("Insert"),
              onPressed: () async {
                await DbHandler().insertData(ModelClass(name: "www", age: 22));
              }),
          ElevatedButton(
              child: const Text("Read"),
              onPressed: () async {
                var data = await DbHandler().readData();
                log("Read Data: $data");
              }),
          ElevatedButton(
              child: const Text("Delete"),
              onPressed: () async {
                await DbHandler().deleteData(2);
              }),
          ElevatedButton(
              child: const Text("Update"),
              onPressed: () async {
                await DbHandler()
                    .updateData(ModelClass(id: 3, name: "prem", age: 33));
              }),
        ],
      )),
    );
  }
}
