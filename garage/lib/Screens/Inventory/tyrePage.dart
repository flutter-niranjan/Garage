import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TyrePage extends StatefulWidget {
  const TyrePage({super.key});

  @override
  State createState() => _TyrePageState();
}

class _TyrePageState extends State {
  int quantity = 0;
  int currIndex = 0;
  final List<Map<String, dynamic>> tyreList = [
    {
      "name": "Apollo",
      "image": "assets/Inventory/Tyre/Apollo.png",
      "price": 10000.0,
      "feature1":
          "1. Performance Features - High-speed stability,Superior wet and dry grip,Low rolling resistance,Enhanced cornering capabilities,Improved braking performance",
      "feature2":
          "2. Durability Features - Long-lasting tread life,Puncture-resistant design,Reinforced sidewalls for added strength,High wear resistance",
      "feature3":
          "3. Comfort & Noise Reduction - Low road noise technology,Vibration absorption design,Enhanced driving comfort",
      "feature4":
          "4. Safety Features - Excellent aquaplaning resistance,Wide circumferential grooves for better water drainage,High traction in wet and dry conditions",
      "feature5":
          "5. Eco-Friendly Features - Low carbon emission tyres,Fuel-efficient design,Made from sustainable rubber compounds",
      "feature6":
          "6. Design Features - Advanced tread pattern for better road grip,Aerodynamic sidewall design,Stylish sidewall branding",
      "feature7":
          "7. Technology Features - Smart tyre pressure monitoring (available in some models),Run-flat technology,Noise-cancelling tech",
      "feature8":
          "8. Warranty & Services - Manufacturer warranty up to 5 years,Roadside assistance services,Free tyre health check-ups",
    },
    {
      "name": "Ceat",
      "image": "assets/Inventory/Tyre/Ceat.png",
      "price": 5000.0,
      "feature1":
          "1. Performance Features - Superior traction on wet and dry roads,High-speed stability,Excellent cornering grip,Enhanced braking performance",
      "feature2":
          "2. Durability Features - High mileage with long-lasting tread life,Reinforced sidewalls for extra strength,Puncture-resistant technology,Robust construction for rough terrains",
      "feature3":
          "3. Comfort & Noise Reduction - Low noise tread pattern,Vibration-resistant technology,Smooth and comfortable rides",
      "feature4":
          "4. Safety Features - Aquaplaning resistance with wide grooves,Strong grip on slippery roads,Quick braking response,High-temperature resistance",
      "feature5":
          "5. Eco-Friendly Features - Fuel-saving low rolling resistance,Eco-friendly rubber compounds,Reduced carbon emissions",
      "feature6":
          "6. Design Features - Modern tread pattern for better aesthetics,Sidewall branding with CEAT logo,Aerodynamic design",
      "feature7":
          "7. Technology Features - Smart Tyre with pressure monitoring (select models),Tubeless tyre technology,Noise cancellation tread blocks",
      "feature8":
          "8.Warranty & Services - Up to 5 years warranty,Free tyre replacement (in selected categories),Roadside assistance",
    },
    {
      "name": "JK Tyres",
      "image": "assets/Inventory/Tyre/JkTyre.png",
      "price": 25000.0,
      "feature1":
          "1. Performance Features - Excellent wet and dry grip,High-speed performance stability,Enhanced braking efficiency,Superior cornering control",
      "feature2":
          "2. Durability Features - Long-lasting tread life,Reinforced sidewalls for added strength,Puncture-resistant design,High wear resistance on rough terrains",
      "feature3":
          "3. Comfort & Noise Reduction - Low noise tread design,Vibration absorption technology,Smooth and comfortable rides",
      "feature4":
          "4. Safety Features - Aquaplaning resistance with wide grooves,Quick braking response,Superior traction on slippery roads,Heat resistance for long drives",
      "feature5":
          "5. Eco-Friendly Features - Low rolling resistance for better fuel efficiency,Eco-friendly rubber compounds,Reduced carbon emissions",
      "feature6":
          "6. Design Features - Modern tread pattern for aesthetics and performance,Stylish sidewall branding,Aerodynamic sidewall design",
      "feature7":
          "7. Technology Features - Smart Tyre Technology (Tyre Pressure Monitoring System),Tubeless tyre variants,Advanced silica-based compounds",
      "feature8":
          "8. Warranty & Services - Up to 5 years warranty,Free tyre replacement under warranty (selected categories)",
    },
    {
      "name": "MRF",
      "image": "assets/Inventory/Tyre/Mrf.png",
      "price": 30000.0,
      "feature1":
          "1. Performance Features - Excellent wet and dry grip,Superior high-speed stability,Enhanced cornering performance,Quick braking response",
      "feature2":
          "2. Durability Features - Long-lasting tread life,Puncture-resistant technology,High wear resistance,Reinforced sidewalls for extra durability",
      "feature3":
          "3. Comfort & Noise Reduction - Low noise tread pattern,Smooth ride on highways and city roads,Vibration-resistant technology",
      "feature4":
          "4. Safety Features - Aquaplaning resistance with wide grooves,Excellent traction on wet and dry surfaces,Strong grip on slippery roads,Superior braking control",
      "feature5":
          "5. Eco-Friendly Features - Low rolling resistance for better fuel efficiency,Eco-friendly rubber compounds,Reduced carbon emissions",
      "feature6":
          "6. Design Features - Modern tread pattern,Stylish sidewall design,Aerodynamic design",
      "feature7":
          "7. Technology Features - Tubeless tyre technology,Smart Tyre variants (Pressure Monitoring System),Noise cancellation tread blocks",
      "feature8":
          "8. Warranty & Services - Up to 6 years warranty,Roadside assistance services,Free tyre replacement under warranty (selected categories)",
    },
  ];

  void nextBattery() {
    setState(() {
      currIndex = (currIndex + 1) % tyreList.length;
    });
  }

  void previousBattery() {
    setState(() {
      currIndex = (currIndex - 1 + tyreList.length) % tyreList.length;
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
          "Tyres",
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
              tyreList[currIndex]["image"],
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
                            tyreList[currIndex]["name"],
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
                            tyreList[currIndex]["feature${index + 1}"];
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
                          "₹ ${tyreList[currIndex]["price"].toStringAsFixed(0)}/-",
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
