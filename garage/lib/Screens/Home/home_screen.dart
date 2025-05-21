import 'package:flutter/material.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:garage/Screens/Home/garage_detail.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  
  @override
  Widget build(BuildContext context) {
    final garageProvider = Provider.of<GarageProvider>(context);
    final garages = garageProvider.garages;

    return Scaffold(
      appBar: AppBar(
        title: Text("Garages"),
      ),
      body: ListView.builder(
        itemCount: garages.length,
        itemBuilder: (context, index) {
          final garage = garages[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GarageDetail(garage: garage),
                ),
              );
            },
            title: Text(garage.name),
            subtitle: Text(
                garage.address),
            leading: garage.images.isNotEmpty
                ? Image.network(
                    garage.images[0],
                    width: 60,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.garage),
          );
        },
      ),
    );
  }
}
