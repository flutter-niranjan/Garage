import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fueltype extends StatefulWidget {
  const Fueltype({super.key});
  @override
  State createState() => _FueltypeState();
}

class _FueltypeState extends State {
  final List<String> fuelTypes = [
    "Petrol",
    "Diesel",
    "Electric",
    "CNG",
    "Hybrid"
  ];
  String? selectedFuelType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 40.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.circle, color: Colors.grey, size: 8),
                SizedBox(width: 4),
                Icon(Icons.circle, color: Colors.red, size: 8),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Please select the",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "Fuel type",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: fuelTypes.map((fuel) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    fuel,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color:
                          fuel == selectedFuelType ? Colors.red : Colors.black,
                      fontWeight: fuel == selectedFuelType
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  trailing: fuel == selectedFuelType
                      ? const Icon(Icons.check, color: Colors.red)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedFuelType = fuel;
                    });
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "ADD",
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
