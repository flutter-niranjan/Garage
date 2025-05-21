import 'package:flutter/material.dart';
import 'package:garage/Model/cart_model.dart';
import 'package:garage/Screens/ServiceBooking/address_slot.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:garage/Model/service_enum.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  Service? _service = Service.pickup;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cart Items
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: cart.services.isEmpty
                    ? [
                        Center(
                          child: Text(
                            "Your cart is empty",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                      ]
                    : cart.services.map((service) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(92, 199, 199, 199),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      cart.serviceImageMap[service["name"]] ??
                                          "assets/Service_Booking/default.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service["name"],
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Full Servicing",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "\Rs${service["price"]}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  cart.removeService(service["name"]);
                                },
                                icon: Icon(Icons.remove_circle_outline),
                                iconSize: 30,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
              ),
            ),

            // Mode of Service Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(92, 199, 199, 199),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 15),
                      child: Text(
                        "Mode of Service",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Radio<Service>(
                          value: Service.pickup,
                          groupValue: _service,
                          onChanged: (Service? value) {
                            setState(() {
                              _service = value;
                            });
                          },
                        ),
                        Text("Pick-up"),
                        SizedBox(width: 20),
                        Radio<Service>(
                          value: Service.walkin,
                          groupValue: _service,
                          onChanged: (Service? value) {
                            setState(() {
                              _service = value;
                            });
                          },
                        ),
                        Text("Walk-in"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bill Section
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Card(
                color: const Color.fromARGB(255, 235, 235, 235),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bill",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      totalBill("Item Total", "Rs. ${cart.totalAmount}"),
                      totalBill("Warranty Fee", "Rs. 99"),
                      Divider(),
                      totalBill("Grand Total", "Rs. ${cart.totalAmount + 99}"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // FAB to proceed
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            if (_service != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddressSlot(
                      serviceMode: _service!), // Assuming this is correct
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please select a service mode")),
              );
            }
          },
          child: Text(
            "Select Address And Slot",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget totalBill(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        Spacer(),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
