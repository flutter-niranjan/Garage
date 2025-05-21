import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Modelselection extends StatefulWidget {
  const Modelselection({super.key});
  @override
  State createState() => _ModelselectionState();
}

class _ModelselectionState extends State {
  final List<String> modelTypes = [
    "1 Series",
    "2 Series",
    "3 Series",
    "4 Series",
    "5 Series",
    "6 Series",
    "7 Series",
    "I Series",
    "M Series",
  ];
  String? selectedModeltype;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
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
                SizedBox(width: 4),
                Icon(Icons.circle, color: Colors.grey, size: 8),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Please Select the",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "Model",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: modelTypes.map((model) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    model,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: model == selectedModeltype
                          ? Colors.red
                          : Colors.black,
                      fontWeight: model == selectedModeltype
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  trailing: model == selectedModeltype
                      ? const Icon(
                          Icons.check,
                          color: Colors.red,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      selectedModeltype = model;
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
