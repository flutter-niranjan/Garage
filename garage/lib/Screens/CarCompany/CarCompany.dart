import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarCompany extends StatefulWidget {
  const CarCompany({super.key});
  @override
  State createState() => _CarCompanyState();
}

class _CarCompanyState extends State {
  final TextEditingController _scearchController = TextEditingController();
  final List<Map<String, String>> carCompanies = [
    {"name": "Manual Entry", "image": "assets/CarCompany/Plus.png"},
    {"name": "Audi", "image": "assets/CarCompany/Audi.png"},
    {"name": "BMW", "image": "assets/CarCompany/BMW.png"},
    {"name": "Chevrolet", "image": "assets/CarCompany/Chevrolet.png"},
    {"name": "Citroen", "image": "assets/CarCompany/Citroen.png"},
    {"name": "Fiat", "image": "assets/CarCompany/Fiat.png"},
    {"name": "Ford", "image": "assets/CarCompany/Ford.png"},
    {"name": "Honda", "image": "assets/CarCompany/Honda.png"},
    {"name": "Hyundai", "image": "assets/CarCompany/Hyundai.png"},
    {"name": "Isuzu", "image": "assets/CarCompany/Isuzu.png"},
    {"name": "Jaguar", "image": "assets/CarCompany/Jaguar.png"},
    {"name": "Jeep", "image": "assets/CarCompany/Jeep.png"},
    {"name": "Kia", "image": "assets/CarCompany/Kia.png"},
    {"name": "Land Rover", "image": "assets/CarCompany/Land Rover.png"},
    {"name": "Mahindra", "image": "assets/CarCompany/Mahindra.png"},
    <String, String>{
      "name": "Mercedes Benz",
      "image": "assets/CarCompany/Mercedes Benz.png"
    },
    <String, String>{"name": "MG", "image": "assets/CarCompany/MG.png"},
    <String, String>{
      "name": "Mitsubishi",
      "image": "assets/CarCompany/Mitsubishi.png"
    },
    <String, String>{"name": "Nissan", "image": "assets/CarCompany/Nissan.png"},
    <String, String>{
      "name": "Renault",
      "image": "assets/CarCompany/Renault.png"
    },
    <String, String>{"name": "Skoda", "image": "assets/CarCompany/Skoda.png"},
    <String, String>{"name": "Suzuki", "image": "assets/CarCompany/Suzuki.png"},
    <String, String>{"name": "Tata", "image": "assets/CarCompany/Tata.png"},
    <String, String>{"name": "Toyota", "image": "assets/CarCompany/Toyota.png"},
    <String, String>{
      "name": "Volkswagen",
      "image": "assets/CarCompany/Volkswagen.png"
    },
    <String, String>{"name": "Volvo", "image": "assets/CarCompany/Volvo.png"},
  ];

  List<Map<String, String>> filteredCompanies = [];

  @override
  void initState() {
    super.initState();
    filteredCompanies = carCompanies;
    _scearchController.addListener(() {
      filterCompanies();
    });
  }

  void filterCompanies() {
    final query = _scearchController.text.toLowerCase();
    setState(() {
      filteredCompanies = carCompanies
          .where((comapny) => comapny["name"]!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _scearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.circle, color: Colors.red, size: 8),
                SizedBox(width: 4),
                Icon(Icons.circle, color: Colors.grey, size: 8),
                SizedBox(width: 4),
                Icon(Icons.circle, color: Colors.grey, size: 8),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Please select the",
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w400),
            ),
            Text(
              "CAR COMPANY",
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w400, color: Colors.red),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _scearchController,
              decoration: InputDecoration(
                hintText: "Search by Company",
                hintStyle: GoogleFonts.poppins(),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.8,
                ),
                itemCount: filteredCompanies.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage(filteredCompanies[index]["image"]!),
                        radius: 30,
                        backgroundColor: Colors.grey.shade200,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        filteredCompanies[index]["name"]!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
