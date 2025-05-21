import 'package:flutter/material.dart';
import 'package:garage/Providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({super.key});
  @override
  State createState() => _MyprofileState();
}

enum Gender { Male, Female }

class _MyprofileState extends State {
  Gender? _gender = Gender.Male;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text =
            "${picked.day.toString().padLeft(2, "0")}/${picked.month.toString().padLeft(2, "0")}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Profile",
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 582,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Colors.black,
              border: Border.all(
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Personal Details",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 115, left: 15, right: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 195, left: 15, right: 15),
                  child: TextField(
                    controller: mobileController,
                    decoration: InputDecoration(
                      labelText: "Mobile No.",
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 275, left: 15, right: 15),
                  child: TextField(
                    readOnly: true,
                    controller: dobController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _selectDate();
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                      labelText: "Date of Birth",
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 350, left: 15),
                  child: Text(
                    "Gender",
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 370, left: 15),
                  child: RadioListTile(
                    title: Text(
                      "Male",
                      style: GoogleFonts.poppins(),
                    ),
                    value: Gender.Male,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 400, left: 15),
                  child: RadioListTile(
                    title: Text(
                      "Female",
                      style: GoogleFonts.poppins(),
                    ),
                    value: Gender.Female,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 500),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      final name = nameController.text.trim();
                      final mobile = mobileController.text.trim();
                      if (name.isNotEmpty && mobile.isNotEmpty) {
                        Provider.of<UserProvider>(context, listen: false)
                            .updateUser(name, mobile);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Profile Saved Successfully")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please fill all the fields")));
                      }
                    },
                    child: Text(
                      "Save",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
