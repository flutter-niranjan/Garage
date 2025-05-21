import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightPage extends StatefulWidget {
  const LightPage({super.key});

  @override
  State createState() => _LightPageState();
}

class _LightPageState extends State {
  int quantity = 0;
  int currIndex = 0;
  final List<Map<String, dynamic>> lightList = [
    {
      "name": "Head Light",
      "image": "assets/Inventory/Lights/Headlight.png",
      "price": 145000.0,
      "feature1":
          "1. Bright Illumination - Provides clear visibility in dark or foggy environments.",
      "feature2":
          "2. LED, Halogen, or HID Options - Available in Halogen, LED, and Xenon HID types for different brightness and energy efficiency.",
      "feature3":
          "3. Waterproof Design - Sealed to protect against water and dust.",
      "feature4":
          "4. Long Lifespan - LED headlights last up to 50,000 hours, making them highly durable.",
      "feature5":
          "5. Energy Efficient - LED headlights consume less power compared to halogen lights.",
      "feature6":
          "6. Adjustable Beam Angles - Allows high and low beam adjustments for better road coverage.",
      "feature7":
          "7. Daytime Running Lights (DRLs) - Improves vehicle visibility during the day.",
      "feature8":
          "8. Anti-Glare Technology - Reduces glare for oncoming traffic, enhancing safety.",
      "feature9":
          "9. Shock and Vibration Resistant - Built to withstand rough roads and bumpy rides.",
      "feature10":
          "10. Automatic On/Off Function - Automatically switches on or off depending on ambient light conditions.",
    },
    {
      "name": "Tail Light",
      "image": "assets/Inventory/Lights/Taillight.png",
      "price": 60000.0,
      "feature1":
          "1. LED, Halogen, or Xenon Options - Available in LED, Halogen, and Xenon for different brightness and efficiency.",
      "feature2":
          "2. Brake Light Integration - Automatically illuminates when the brake pedal is pressed.",
      "feature3":
          "3. Waterproof and Dustproof Design - Sealed to withstand harsh weather conditions.",
      "feature4":
          "4. Energy Efficient - LED tail lights consume less power compared to halogen lights.",
      "feature5":
          "5. Long Lifespan - LED tail lights can last up to 50,000 hours.",
      "feature6":
          "6. High Visibility - Provides bright red light for better rear-end visibility at night.",
      "feature7":
          "7. Reverse Light Function - White light indicates when the vehicle is in reverse gear.",
      "feature8":
          "8. Turn Signal Indicator - Amber or red flashing light signals turning intentions.",
      "feature9":
          "9. Shock and Vibration Resistant - Designed to endure rough terrains and bumps.",
      "feature10":
          "10. Stylish Design Options - Available in modern, sleek designs to enhance vehicle aesthetics.",
    },
    {
      "name": "Fog Lights",
      "image": "assets/Inventory/Lights/Foglight.png",
      "price": 20000.0,
      "feature1":
          "1. Low Beam Design - Emits a wide and low beam to cut through fog without blinding other drivers.",
      "feature2":
          "2. LED, Halogen, or HID Options - Available in LED (energy-efficient), Halogen (affordable), and HID (high brightness) options.",
      "feature3":
          "3. Waterproof and Dustproof Casing - Sealed housing to withstand rain, dust, and snow.",
      "feature4":
          "4. High Brightness with Low Glare - Provides better road illumination without dazzling oncoming vehicles.",
      "feature5":
          "5. Shock Resistant - Built to withstand vibrations on rough terrains.",
      "feature6":
          "6. Durable Lifespan - LED fog lights can last up to 30,000 - 50,000 hours.",
      "feature7":
          "7. Yellow or White Light Output - Yellow lights improve visibility in dense fog, while white lights are suitable for light fog.",
      "feature8":
          "8. Energy Efficient - Consumes less power compared to standard headlights.",
      "feature9":
          "9. Easy Installation - Direct fit for most vehicles with plug-and-play connectors.",
      "feature10":
          "10. Aesthetic Design - Enhances the look of the car while providing functionality.",
    },
  ];

  void nextBattery() {
    setState(() {
      currIndex = (currIndex + 1) % lightList.length;
    });
  }

  void previousBattery() {
    setState(() {
      currIndex = (currIndex - 1 + lightList.length) % lightList.length;
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
          "Lights",
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
              lightList[currIndex]["image"],
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
                            lightList[currIndex]["name"],
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
                            lightList[currIndex]["feature${index + 1}"];
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
                          "₹ ${lightList[currIndex]["price"].toStringAsFixed(0)}/-",
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
