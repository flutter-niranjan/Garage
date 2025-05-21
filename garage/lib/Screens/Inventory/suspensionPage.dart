import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuspensionPage extends StatefulWidget {
  const SuspensionPage({super.key});

  @override
  State createState() => _SuspensionPageState();
}

class _SuspensionPageState extends State {
  int quantity = 0;
  int currIndex = 0;
  final List<Map<String, dynamic>> suspensionList = [
    {
      "name": "Front Shock Absorber",
      "image": "assets/Inventory/Suspension/Front_Shock_Absorber.png",
      "price": 45000.0,
      "feature1":
          "1. Shock Absorption - Reduces vibrations and impacts from bumps, potholes, and uneven roads.",
      "feature2":
          "2. Hydraulic Damping System - Uses hydraulic fluid to absorb and dissipate energy from road shocks.",
      "feature3":
          "3. Improved Ride Comfort - Provides a smoother ride by minimizing road disturbances.",
      "feature4":
          "4. Enhanced Vehicle Stability - Prevents excessive body roll during cornering and braking.",
      "feature5":
          "5. Durability & Longevity - Made from high-quality steel with corrosion-resistant coatings.",
      "feature6":
          "6. Noise-Free Operation - Built with advanced sealing technology to reduce noise.",
      "feature7":
          "7. Temperature Resistant - Operates efficiently in extreme weather conditions.",
      "feature8":
          "8. Oil-Sealed Design - Prevents oil leakage for consistent performance.",
      "feature9":
          "9. Easy Installation - Designed to fit directly into the vehicle's suspension system.",
      "feature10":
          "10. ABS & Suspension Compatibility - Works seamlessly with advanced braking and suspension systems.",
    },
    {
      "name": "Rear Shock Absorber",
      "image": "assets/Inventory/Suspension/Rear_Shock_Absorber.png",
      "price": 30000.0,
      "feature1":
          "1. Shock Damping System - Absorbs and dissipates energy from road bumps and vibrations.",
      "feature2":
          "2. Hydraulic or Gas-Filled Design - Uses hydraulic oil or nitrogen gas to provide consistent damping.",
      "feature3":
          "3. Enhanced Vehicle Stability - Prevents excessive rear-end bouncing and maintains vehicle balance.",
      "feature4":
          "4. Anti-Corrosion Coating - Made from high-quality steel with rust-resistant coatings.",
      "feature5":
          "5. Temperature Resistant - Performs well in both high and low temperatures.",
      "feature6":
          "6. Noise-Free Operation - Equipped with advanced seals to prevent noise during operation.",
      "feature7":
          "7. Improved Road Grip - Helps keep tires in contact with the road for better traction.",
      "feature8":
          "8. Easy Installation - Direct fit design for hassle-free replacement.",
      "feature9":
          "9. Durability & Longevity - Built to withstand rough terrain and long-distance driving.",
      "feature10":
          "10. Reduced Vibration Transmission - Minimizes vibrations transferred to the car body.",
    },
    {
      "name": "Front Axle",
      "image": "assets/Inventory/Suspension/Front_Axle.png",
      "price": 15000.0,
      "feature1":
          "1. Load Bearing Capacity - Supports the weight of the vehicle and front-end components like the engine.",
      "feature2":
          "2. Steering Mechanism Integration - Facilitates wheel steering movement for better vehicle control.",
      "feature3":
          "3. Shock Absorption - Works with shock absorbers and suspension springs to absorb road shocks.",
      "feature4":
          "4. High-Strength Material - Made from forged steel or alloy steel for durability and strength.",
      "feature5":
          "5. Camber Angle Adjustment - Provides alignment settings to ensure proper tire contact with the road.",
      "feature6":
          "6. Kingpin and Wheel Hub Support - Houses the kingpin to support the wheel hub and wheel assembly.",
      "feature7":
          "7. Vibration Dampening - Reduces vibrations from uneven surfaces.",
      "feature8":
          "8. Brake System Mounting - Provides mounting points for disc brakes or drum brakes.",
      "feature9":
          "9. Corrosion Resistant Coating - Protected with anti-rust material for longer lifespan.",
      "feature10":
          "10. Independent or Rigid Construction - Can be designed as an independent front axle or rigid front axle based on vehicle type.",
    },
    {
      "name": "Link Rod",
      "image": "assets/Inventory/Suspension/Link_Rod.png",
      "price": 5000.0,
      "feature1":
          "1. Stability Enhancement - Reduces body roll during cornering and sharp turns.",
      "feature2":
          "2. High-Strength Material - Made from forged steel or aluminum for durability and performance.",
      "feature3":
          "3. Ball Joint Design - Allows smooth rotational movement for better suspension flexibility.",
      "feature4":
          "4. Rubber Bushings - Provides cushioning and absorbs minor shocks.",
      "feature5":
          "5. Corrosion Resistant Coating - Protected with zinc or powder coating to prevent rust.",
      "feature6":
          "6. Noise Reduction - Built with silent bushings for noise-free operation.",
      "feature7":
          "7. Easy Installation - Direct fit design for quick replacement.",
      "feature8":
          "8. Improved Vehicle Handling - Helps maintain tire contact with the road during turns.",
      "feature9":
          "9. Wear Resistant - Long lifespan even in rough driving conditions.",
      "feature10":
          "10. Lightweight Construction - Minimizes the overall weight of the suspension system.",
    },
    {
      "name": "Tie Rod",
      "image": "assets/Inventory/Suspension/Tie_Rod.png",
      "price": 8000.0,
      "feature1":
          "1. Steering Control - Transfers steering input from the steering rack to the front wheels for precise turning.",
      "feature2":
          "2. High-Strength Material - Made from hardened steel or aluminum alloy for durability.",
      "feature3":
          "3. Ball Joint Design - Provides smooth pivoting motion for better steering response.",
      "feature4":
          "4. Corrosion Resistant Coating - Protected with zinc plating or powder coating to prevent rust.",
      "feature5":
          "5. Adjustable Length - Allows for wheel alignment adjustments.",
      "feature6":
          "6. Shock Absorption - Reduces vibrations transmitted from the wheels to the steering system.",
      "feature7":
          "7. Noise-Free Operation - Equipped with silent bushings and grease fittings.",
      "feature8":
          "8. Durability & Longevity - Designed to withstand heavy loads and rough terrain.",
      "feature9":
          "9. Quick Installation - Direct fitment for easy replacement.",
      "feature10":
          "10. Improved Vehicle Stability - Maintains correct front wheel alignment for stable driving.",
    },
  ];

  void nextBattery() {
    setState(() {
      currIndex = (currIndex + 1) % suspensionList.length;
    });
  }

  void previousBattery() {
    setState(() {
      currIndex = (currIndex - 1 + suspensionList.length) % suspensionList.length;
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
          "Suspension",
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
              suspensionList[currIndex]["image"],
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
                            suspensionList[currIndex]["name"],
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
                            suspensionList[currIndex]["feature${index + 1}"];
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
                          "₹ ${suspensionList[currIndex]["price"].toStringAsFixed(0)}/-",
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
