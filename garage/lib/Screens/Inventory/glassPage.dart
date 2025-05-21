import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassPage extends StatefulWidget {
  const GlassPage({super.key});

  @override
  State createState() => _GlassPageState();
}

class _GlassPageState extends State {
  int quantity = 0;
  int currIndex = 0;
  final List<Map<String, dynamic>> glassList = [
    {
      "name": "Windshield",
      "image": "assets/Inventory/Glass/Windshield.png",
      "price": 20000.0,
      "feature1":
          "1. Laminated Safety Glass - Made with two layers of glass with a PVB (Polyvinyl Butyral) layer in between for added strength and safety.",
      "feature2":
          "2. UV Protection Coating - Blocks harmful UV rays, protecting passengers and the car's interior.",
      "feature3":
          "3. Shatter-Resistant Design - Prevents glass from breaking into sharp pieces during impact.",
      "feature4":
          "4. Sound Insulation - Reduces outside noise for a quieter driving experience.",
      "feature5":
          "5. Built-in Defogger Lines - Available in some models to prevent fogging during winter.",
    },
    {
      "name": "Back Window",
      "image": "assets/Inventory/Glass/Back_Window.png",
      "price": 25000.0,
      "feature1":
          "1. Tempered Glass Construction - Made from heat-treated glass that is more durable and shatter-resistant.",
      "feature2":
          "2. Defogger/Defroster Lines - Thin heating elements embedded in the glass to prevent fogging or frost buildup.",
      "feature3":
          "3. UV Protection Coating - Blocks harmful UV rays, reducing heat inside the cabin.",
      "feature4":
          "4. Aesthetic Design - Designed to blend seamlessly with the car’s body structure.",
      "feature5":
          "5. Rear Wiper Compatibility - Supports installation of rear windshield wipers in hatchbacks and SUVs.",
    },
    {
      "name": "Front Door Glass",
      "image": "assets/Inventory/Glass/Front_Door_Glass.png",
      "price": 10000.0,
      "feature1":
          "1. Tempered Safety Glass - Made from toughened glass that shatters into small, blunt pieces upon impact for safety.",
      "feature2":
          "2. Power Window Compatibility - Designed to work with automatic and manual window mechanisms.",
      "feature3":
          "3. UV Protection Coating - Reduces exposure to harmful UV rays, protecting passengers and the interior.",
      "feature4":
          "4.Scratch-Resistant Surface - Treated with a durable coating to prevent minor scratches and extend lifespan.",
      "feature5":
          "5. Water Repellent Coating - Enhances visibility during rain by causing water to bead and roll off.",
    },
    {
      "name": "Rear Door Glass",
      "image": "assets/Inventory/Glass/Rear_Door_Glass.png",
      "price": 30000.0,
      "feature1":
          "1. Tempered Safety Glass - Made from toughened glass that shatters into small, blunt pieces upon impact for safety.",
      "feature2":
          "2. Power Window Compatibility - Designed to work with automatic and manual window mechanisms.",
      "feature3":
          "3. UV Protection Coating - Reduces exposure to harmful UV rays, protecting passengers and the interior.",
      "feature4":
          "4.Scratch-Resistant Surface - Treated with a durable coating to prevent minor scratches and extend lifespan.",
      "feature5":
          "5. Water Repellent Coating - Enhances visibility during rain by causing water to bead and roll off.",
    },
    {
      "name": "Rear Quarter Glass",
      "image": "assets/Inventory/Glass/Rear_Quater.png",
      "price": 20000.0,
      "feature1":
          "1. Tempered Safety Glass - Made from toughened glass that shatters into small, blunt pieces for passenger safety during impacts.",
      "feature2":
          "2. Fixed or Ventilation Design - Available in fixed designs or with small openings for extra airflow.",
      "feature3":
          "3. UV Protection Coating - Blocks harmful UV rays, protecting passengers and reducing cabin heat.",
      "feature4":
          "4. Scratch-Resistant Surface - Coated to resist scratches and maintain clarity over time",
      "feature5":
          "5. Customization Options - Available in different tints and shapes to match vehicle design.",
    },
    {
      "name": "Vent Glass",
      "image": "assets/Inventory/Glass/Vent.png",
      "price": 20000.0,
      "feature1":
          "1. Tempered Safety Glass - Made from toughened glass that shatters into small, blunt pieces for passenger safety during impacts.",
      "feature2":
          "2. Fixed or Ventilation Design - Available in fixed designs or with small openings for extra airflow.",
      "feature3":
          "3. UV Protection Coating - Blocks harmful UV rays, protecting passengers and reducing cabin heat.",
      "feature4":
          "4. Scratch-Resistant Surface - Coated to resist scratches and maintain clarity over time",
      "feature5":
          "5. Customization Options - Available in different tints and shapes to match vehicle design.",
    },
  ];

  void nextBattery() {
    setState(() {
      currIndex = (currIndex + 1) % glassList.length;
    });
  }

  void previousBattery() {
    setState(() {
      currIndex = (currIndex - 1 + glassList.length) % glassList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Glass",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.5,
                colors: [Colors.red, Colors.white],
                stops: [0.3, 1.0],
              ),
            ),
            margin: const EdgeInsets.only(left: 50),
            child: Image.asset(
              glassList[currIndex]["image"],
              height: 200,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: previousBattery,
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        margin: const EdgeInsets.only(top: 10, left: 55),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            glassList[currIndex]["name"],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 65),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: nextBattery,
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        String? feature =
                            glassList[currIndex]["feature${index + 1}"];
                        if (feature != null) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              feature,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "₹ ${glassList[currIndex]["price"].toStringAsFixed(0)}/-",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) quantity--;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "$quantity",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
