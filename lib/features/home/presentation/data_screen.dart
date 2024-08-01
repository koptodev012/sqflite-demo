import 'package:flutter/material.dart';
import 'package:sqflite_demo/features/home/model/model_class.dart';
import 'package:sqflite_demo/features/home/services/db_handler.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  late Future<List<ModelClass>> dataFuture;

  @override
  void initState() {
    super.initState();
    dataFuture = DbHandler().readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Screen"),
      ),
      body: FutureBuilder<List<ModelClass>>(
        future: dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].name),
                  subtitle: Text(data[index].age.toString()),
                  trailing: IconButton(
                    onPressed: () {
                      if (data[index].id != null) {
                        DbHandler().deleteData(data[index].id!);
                        setState(() {
                          dataFuture = DbHandler().readData();
                        });
                      }
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
