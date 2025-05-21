import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrakePage extends StatefulWidget {
  const BrakePage({super.key});

  @override
  State createState() => _BrakePageState();
}

class _BrakePageState extends State {
  int quantity = 0;
  int currIndex = 0;
  final List<Map<String, dynamic>> brakeList = [
    {
      "name": "Disc Brakes",
      "image": "assets/Inventory/Brake/Disc_Brake.png",
      "price": 22000.0,
      "feature1":
          "1. High Braking Performance - Provides superior braking efficiency even at high speeds.",
      "feature2":
          "2. Heat Dissipation - Ventilated discs help in faster heat dissipation, preventing brake fade.",
      "feature3":
          "3. Quick Response - Offers faster braking action compared to drum brakes.",
      "feature4":
          "4. Durability - Made from Cast Iron, Ceramic, or Carbon Composites for long lifespan.",
      "feature5":
          "5. Anti-Lock Braking System (ABS) Compatibility - Works seamlessly with ABS for safer braking.",
      "feature6":
          "6. Low Maintenance - Easier to inspect and replace than drum brakes.",
      "feature7":
          "7. Self-Adjusting Mechanism - Automatically maintains the correct distance between pads and disc.",
      "feature8":
          "8. Water Resistance - Less prone to performance loss in wet conditions.",
      "feature9":
          "9. Noise Reduction - Modern pads include noise-dampening features.",
      "feature10":
          "10. Lightweight Design - Contributes to overall vehicle weight reduction and better fuel efficiency.",
    },
    {
      "name": "Front Brake Pads",
      "image": "assets/Inventory/Brake/Front_Brake_Pads.png",
      "price": 25000.0,
      "feature1":
          "1. High Friction Material - Made from Ceramic, Semi-Metallic, or Organic materials for superior braking performance.",
      "feature2":
          "2. Wear Resistance - Designed to withstand high temperatures and long usage without excessive wear.",
      "feature3":
          "3. Noise Reduction - Equipped with Anti-Squeal Shims to minimize noise during braking.",
      "feature4":
          "4. Heat Dissipation - High thermal conductivity prevents overheating and brake fade.",
      "feature5":
          "5. Dust-Free Operation - Low-dust materials keep wheels cleaner.",
      "feature6":
          "6. ABS Compatibility - Works efficiently with Anti-Lock Braking Systems.",
      "feature7":
          "7. Corrosion Resistance - Coated with anti-rust material for durability.",
      "feature8":
          "8. Easy Installation - Pre-fitted clips and shims for hassle-free installation.",
      "feature9":
          "9. Improved Stopping Power - Provides strong braking force even at high speeds.",
      "feature10":
          "10. Eco-Friendly Materials - Free from harmful substances like asbestos.",
    },
    {
      "name": "Rear Brake Pads",
      "image": "assets/Inventory/Brake/Rear_Brake_Pads.png",
      "price": 20000.0,
      "feature1":
          "1. Balanced Braking Performance - Provides support to front brake pads, ensuring even braking distribution.",
      "feature2":
          "2. High Durability - Made from Ceramic, Semi-Metallic, or Organic materials to withstand prolonged use.",
      "feature3":
          "3. Low Noise Operation - Equipped with Anti-Squeal Shims for quieter braking.",
      "feature4":
          "4. Heat Resistance - Designed to operate under high temperatures without losing performance.",
      "feature5":
          "5. Dust-Free Technology - Produces minimal brake dust, keeping wheels clean.",
      "feature6":
          "6. Corrosion Resistance - Coated with anti-rust material for a longer lifespan.",
      "feature7":
          "7. ABS Compatibility - Works efficiently with Anti-Lock Braking Systems.",
      "feature8":
          "8. Eco-Friendly Material - Free from asbestos and other harmful substances.",
      "feature9":
          "9. Vibration Reduction - Built to absorb vibrations for smoother braking.",
      "feature10":
          "10. Quick Installation - Pre-fitted clips and shims allow for easy replacement.",
    },
  ];

  void nextBattery() {
    setState(() {
      currIndex = (currIndex + 1) % brakeList.length;
    });
  }

  void previousBattery() {
    setState(() {
      currIndex = (currIndex - 1 + brakeList.length) % brakeList.length;
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
          "Brakes",
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
              brakeList[currIndex]["image"],
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
                            brakeList[currIndex]["name"],
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
                            brakeList[currIndex]["feature${index + 1}"];
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
                          "₹ ${brakeList[currIndex]["price"].toStringAsFixed(0)}/-",
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
