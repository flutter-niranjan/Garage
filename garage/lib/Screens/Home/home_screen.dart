import 'package:flutter/material.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:garage/Screens/Home/garage_detail.dart';
import 'package:garage/Screens/Home/userhomepage.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
final PersistentTabController controller;
  const HomeScreen({super.key, required this.controller});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
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
                  builder: (context) => GarageDetail(garage: garage,controller: widget.controller,),
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
