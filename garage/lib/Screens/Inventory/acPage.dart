import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcPage extends StatefulWidget {
  const AcPage({super.key});

  @override
  State createState() => _AcPageState();
}

class _AcPageState extends State {
  int quantity = 0;
  int currIndex = 0;
  final List<Map<String, dynamic>> acList = [
    {
      "name": "Cooling Coil",
      "image": "assets/Inventory/AC/ac_cooling_coil.png",
      "price": 30000.0,
      "feature1":
          "1. Heat Absorption - The cooling coil absorbs heat from the air inside the room, lowering the air temperature.",
      "feature2":
          "2. Air Cooling Process - Refrigerant circulates through the cooling coil, converting hot air into cool air through the evaporation process.",
      "feature3":
          "3. Dehumidification - The coil removes excess moisture from the air, improving comfort and air quality.",
      "feature4":
          "4. Efficient Cooling Performance - Ensures the AC delivers consistent and uniform cooling across the room.",
      "feature5":
          "5. Energy Efficiency - Properly maintained coils enhance the energy efficiency of the AC system, reducing power consumption.",
      "feature6":
          "6. Air Quality Improvement - Helps filter out dust and allergens while cooling the air.",
      "feature7":
          "7. Prevents Compressor Overload - Efficient coils help maintain proper pressure and temperature in the refrigerant cycle, protecting the compressor.",
      "feature8":
          "8. Warranty Coverage - Available with 24-48 months warranty options.",
      "feature9":
          "9. Durability & Longevity - High-quality coils improve the lifespan of the AC system.",
    },
    {
      "name": "Compressor",
      "image": "assets/Inventory/AC/Compressor.png",
      "price": 85000.0,
      "feature1":
          "1. Refrigerant Circulation - The compressor pumps refrigerant through the system, enabling heat exchange between indoor and outdoor units.",
      "feature2":
          "2. Heat Transfer - Compresses low-pressure, low-temperature gas into high-pressure, high-temperature gas, which helps release heat from the indoor air.",
      "feature3":
          "3. Cooling Efficiency - A well-functioning compressor ensures faster and more efficient cooling.",
      "feature4":
          "4. Pressure Regulation - Maintains proper pressure levels in the system to allow smooth refrigerant flow.",
      "feature5":
          "5. Energy Consumption Control - Modern Inverter Compressors adjust their speed to save energy and improve efficiency.",
      "feature6":
          "6. System Lifespan - A properly working compressor extends the lifespan of the AC unit.",
      "feature7":
          "7. Noise Control - Advanced compressors reduce operational noise for a quieter environment.",
      "feature8":
          "8. Prevents Refrigerant Loss - Helps avoid leakage and ensures proper refrigerant flow.",
      "feature9":
          "9. Warranty Coverage - Available with 18-48 months warranty options.",
    },
    {
      "name": "Condenser",
      "image": "assets/Inventory/AC/Condenser.png",
      "price": 20000.0,
      "feature1":
          "1.Heat Release Process - Converts high-pressure, high-temperature refrigerant gas into a liquid by dissipating heat into the surrounding air.",
      "feature2":
          "2. Cooling Cycle Completion - Facilitates the transition of refrigerant from gas to liquid, essential for continuous cooling.",
      "feature3":
          "3. Efficiency Enhancement - A high-quality condenser improves the overall efficiency of the AC unit, reducing energy consumption.",
      "feature4":
          "4. Temperature Control - Helps maintain a consistent cooling temperature.",
      "feature5":
          "5. Compressor Protection - Prevents overheating of the compressor by properly managing refrigerant temperature.",
      "feature6":
          "6. Durability & Longevity - Corrosion-resistant condensers increase the lifespan of the AC system.",
      "feature7":
          "7. Outdoor Unit Functionality - Works efficiently even in extreme weather conditions.",
      "feature8":
          "8. Noise Reduction - Modern condensers operate silently, enhancing the user experience.",
      "feature9":
          "9. Warranty Coverage - Available with 18-42 months warranty options.",
    },
    {
      "name": "Heating Coil",
      "image": "assets/Inventory/AC/Heating_Coil.png",
      "price": 30000.0,
      "feature1":
          "1. Heat Generation - Converts electrical energy into heat to warm the air passing through the coil.",
      "feature2":
          "2. Dual Functionality - Allows air conditioners to work as both cooling and heating units.",
      "feature3":
          "3. Temperature Regulation- Provides consistent and controlled heating to maintain a comfortable room temperature.",
      "feature4":
          "4. Energy Efficiency - Modern heating coils are designed to consume less energy while delivering maximum heat output.",
      "feature5":
          "5. Quick Heating Response - Heats the air quickly, providing instant warmth.",
      "feature6":
          "6. Durability - Made from Copper or Aluminum for better heat conduction and long lifespan.",
      "feature7":
          "7. Air Quality Improvement - Prevents moisture buildup, reducing mold growth.",
      "feature8":
          "8. Safety Features - Equipped with Thermal Cutoff Protection to prevent overheating.",
      "feature9":
          "9. Warranty Coverage - Available with 18-36 months warranty options.",
    },
    {
      "name": "V Belt",
      "image": "assets/Inventory/AC/V_Belt.png",
      "price": 10000.0,
      "feature1":
          "1. Power Transmission - Transfers power from the AC motor to the compressor, enabling the refrigeration cycle.",
      "feature2":
          "2. High Efficiency - Provides efficient power transmission with minimal energy loss.",
      "feature3":
          "3. Shock Absorption - Absorbs shocks and vibrations, protecting the motor and compressor from damage.",
      "feature4":
          "4. Slip Resistance - Wedge-shaped design ensures better grip and prevents slipping under heavy loads.",
      "feature5":
          "5. Durability - Made from rubber with reinforced fibers for long-lasting performance.",
      "feature6":
          "6. Cost-Effective - Affordable and easy to replace compared to other transmission systems.",
      "feature7":
          "7. Low Noise Operation - Provides quieter operation with minimal mechanical noise.",
      "feature8":
          "8. Flexibility - Works efficiently even in variable speed applications.",
      "feature9":
          "9. Warranty Coverage - Available with 24-48 months warranty options.",
    },
  ];

  void nextBattery() {
    setState(() {
      currIndex = (currIndex + 1) % acList.length;
    });
  }

  void previousBattery() {
    setState(() {
      currIndex = (currIndex - 1 + acList.length) % acList.length;
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
          "AC Parts",
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
              acList[currIndex]["image"],
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
                            acList[currIndex]["name"],
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
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        String? feature =
                            acList[currIndex]["feature${index + 1}"];
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
                          "₹ ${acList[currIndex]["price"].toStringAsFixed(0)}/-",
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
