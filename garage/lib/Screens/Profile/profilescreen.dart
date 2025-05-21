import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garage/Providers/user_provider.dart';
import 'package:garage/Screens/Profile/myprofile.dart';
import 'package:garage/Screens/Profile/register_partner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15),
            child: Text(
              "Hello,",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 65, left: 15),
                child: Text(
                  user.name.isNotEmpty ? user.name : "Customer",
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 65, right: 15),
                child: Text(
                  user.mobile.isNotEmpty
                      ? "+91 ${user.mobile}"
                      : "+91 0000000000",
                  style: GoogleFonts.poppins(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color.fromARGB(255, 211, 211, 211),
                    ),
                    onPressed: () {},
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset("assets/Profile/OrderHistory.png"),
                        ),
                        Text(
                          "Order History",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color.fromARGB(255, 211, 211, 211),
                    ),
                    onPressed: () {},
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset("assets/Profile/Vehicle.png"),
                        ),
                        Text(
                          "My Vehicle",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color.fromARGB(255, 211, 211, 211),
                    ),
                    onPressed: () {},
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset("assets/Profile/Support.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Help",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 280),
            child: Divider(
              thickness: 2.5,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 290, left: 10, right: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Myprofile()));
              },
              child: Row(
                children: [
                  Image.asset("assets/Profile/Profile.png"),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Profile",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  Image.asset("assets/Profile/next.png"),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 335),
            child: Divider(
              thickness: 2.5,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 345, left: 10, right: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset("assets/Profile/Earn.png"),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Refer & Earn",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  Image.asset("assets/Profile/next.png"),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 390),
            child: Divider(
              thickness: 2.5,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 405, left: 10, right: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPartner()));
              },
              child: Row(
                children: [
                  Image.asset("assets/Profile/Partner.png"),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Register as Partner",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  Image.asset("assets/Profile/next.png"),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 450),
            child: Divider(
              thickness: 2.5,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
