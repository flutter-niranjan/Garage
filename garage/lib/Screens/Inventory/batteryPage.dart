import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State createState() => _BatteryPageState();
}

class _BatteryPageState extends State {
  int quantity = 0;
  int currIndex = 0;
  final List<Map<String, dynamic>> batteryList = [
    {
      "name": "Exide",
      "image": "assets/Inventory/Battery/Exide.png",
      "price": 20000.0,
      "feature1": "1. High Cranking Power - Ensures quick engine start.",
      "feature2":
          "2. Longer Battery Life - Designed for durability and long life.",
      "feature3":
          "3. Maintenance-Free Design - No need for frequent water topping.",
      "feature4":
          "4. Leak-Proof Construction - Advanced venting system to prevent leaks.",
      "feature5":
          "5. Enhanced Safety Features - Factory-sealed with flame arrestors.",
      "feature6": "6. Fast Charging Capability - Quick recharge technology.",
      "feature7": "7. Vibration Resistant Design - Ideal for rough terrains.",
      "feature8":
          "8. Warranty Coverage - Available with 24-48 months warranty options.",
      "feature9":
          "9. High Heat Tolerance - Performs well in extreme weather conditions.",
      "feature10":
          "10. Eco-Friendly - Built with recycled lead and environment-friendly materials.",
    },
    {
      "name": "Amaron",
      "image": "assets/Inventory/Battery/amaron.png",
      "price": 25000.0,
      "feature1": "1. High Cranking Power - Quick and consistent engine start.",
      "feature2": "2. Zero Maintenance - No water top-up required.",
      "feature3":
          "3. Long Battery Life - High heat resistance for longer lifespan.",
      "feature4":
          "4. Vibration Resistant - Suitable for rough and uneven terrains.",
      "feature5":
          "5. Corrosion-Resistant Grid Technology - Ensures durability.",
      "feature6":
          "6. High Reserve Capacity - Provides backup during alternator failure.",
      "feature7":
          "7. Factory Charged Battery - Ready to use, no initial charging required.",
      "feature8": "8. Leak-Proof Design - Safety-assured construction.",
      "feature9": "9. Eco-Friendly - Recyclable materials used.",
      "feature10":
          "10. Warranty Coverage - Available with 18-48 months warranty options.",
    },
    {
      "name": "Acdelco",
      "image": "assets/Inventory/Battery/acdelco.png",
      "price": 10000.0,
      "feature1": "1. High Cranking Power - Delivers reliable engine starts.",
      "feature2":
          "2. Maintenance-Free Design - Sealed battery with no water top-up required.",
      "feature3":
          "3. Long Battery Life - Extended lifespan with corrosion-resistant technology.",
      "feature4": "4. Vibration Resistant - Ideal for rough terrains.",
      "feature5":
          "5. Calcium-Calcium Technology - Improves performance and battery life.",
      "feature6":
          "6. High Reserve Capacity - Provides backup during alternator failure.",
      "feature7":
          "7. Leak-Proof Design - Prevents acid leaks with sealed construction.",
      "feature8":
          "8. High Heat Tolerance - Performs well in extreme temperatures.",
      "feature9": "9. Eco-Friendly - Made with recyclable materials.",
      "feature10":
          "10. Warranty Coverage - Available with 18-42 months warranty options.",
    },
    {
      "name": "Luminous",
      "image": "assets/Inventory/Battery/luminous.png",
      "price": 30000.0,
      "feature1": "1. High Cranking Power - Ensures smooth engine starts.",
      "feature2":
          "2. Maintenance-Free Design - No frequent water topping required.",
      "feature3":
          "3. Long Battery Life - Designed for durability with superior grid technology.",
      "feature4":
          "4. High Heat Tolerance - Performs well in extreme weather conditions.",
      "feature5": "5. Vibration Resistant - Ideal for rough terrains.",
      "feature6": "6. Leak-Proof Design - Advanced sealed construction.",
      "feature7":
          "7. Fast Recharge Technology - Quick charging for faster recovery.",
      "feature8": "8. Eco-Friendly - Made with recyclable materials.",
      "feature9":
          "9. Warranty Coverage - Available with 18-36 months warranty options.",
      "feature10":
          "10. Deep Discharge Protection - Protects battery from excessive discharge.",
    },
    {
      "name": "Bosch",
      "image": "assets/Inventory/Battery/bosch.png",
      "price": 20000.0,
      "feature1":
          "1. High Cranking Power - Ensures quick engine starts even in cold weather.",
      "feature2":
          "2. Maintenance-Free Design - Sealed battery with no water top-up required.",
      "feature3":
          "3. Long Battery Life - Enhanced durability with Silver Alloy Technology.",
      "feature4":
          "4. Vibration Resistant - Suitable for rough and uneven terrains.",
      "feature5":
          "5. High Heat Tolerance - Performs well in extreme temperatures.",
      "feature6":
          "6. Fast Charging Capability - Quick recharge for better performance.",
      "feature7":
          "7. Corrosion-Resistant Grid Technology - Prolongs battery life.",
      "feature8":
          "8. Leak-Proof Design - Advanced safety features with sealed casing.",
      "feature9": "9. Eco-Friendly - Made with recyclable materials.",
      "feature10":
          "10. Warranty Coverage - Available with 24-48 months warranty options.",
    },
  ];

  void nextBattery() {
    setState(() {
      currIndex = (currIndex + 1) % batteryList.length;
    });
  }

  void previousBattery() {
    setState(() {
      currIndex = (currIndex - 1 + batteryList.length) % batteryList.length;
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
          "Battery",
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
              batteryList[currIndex]["image"],
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
                            batteryList[currIndex]["name"],
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
                            batteryList[currIndex]["feature${index + 1}"];
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
                          "₹ ${batteryList[currIndex]["price"].toStringAsFixed(0)}/-",
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
