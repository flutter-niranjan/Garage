import 'package:flutter/material.dart';
import 'package:garage/Screens/ServiceBooking/select_address.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:garage/Model/service_enum.dart';
import 'package:provider/provider.dart';
import 'package:garage/Model/cart_model.dart';

class AddressSlot extends StatefulWidget {
  final Service serviceMode;
  const AddressSlot({super.key, required this.serviceMode});

  @override
  State<AddressSlot> createState() => _AddressSlotState();
}

class _AddressSlotState extends State<AddressSlot> {
  String _selectedAddress = "Narhe, Pune, Maharashtra 411041, India";
  int? _selectedDateIndex;
  int? _selectedTimeSlotIndex;
  String _selectedPaymentMode = "";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    const int warrantyFee = 99;
    double grandTotal = cart.totalAmount + warrantyFee;

    String modeText =
        widget.serviceMode == Service.pickup ? "Pick-up" : "Walk-in";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking Details",
          style: GoogleFonts.poppins(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
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
                      "Cart Summary",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Mode : $modeText",
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            _selectedAddress,
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectAddress()),
                            );
                            if (result != null) {
                              setState(() {
                                _selectedAddress = result;
                              });
                            }
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (cart.services.isNotEmpty)
                      Text(
                        "Selected Servicing: ${cart.services.map((e) => e["name"]).join(', ')}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    SizedBox(height: 8),
                    Text(
                      "Bill",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    totalBill("Item Total", "Rs. ${cart.totalAmount}"),
                    totalBill("Warranty Fee", "Rs. $warrantyFee"),
                    Divider(),
                    totalBill("Grand Total", "Rs. $grandTotal"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Select Date",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  DateTime date = DateTime.now().add(Duration(days: index));
                  String formattedDate = "${date.day}/${date.month}";
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        formattedDate,
                        style: GoogleFonts.poppins(
                          color: _selectedDateIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      selected: _selectedDateIndex == index,
                      selectedColor: Colors.red,
                      backgroundColor: Colors.grey[200],
                      showCheckmark: true,
                      checkmarkColor: Colors.white,
                      onSelected: (value) {
                        setState(() {
                          _selectedDateIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Select Time",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(8, (index) {
                int startHour = 9 + index;
                String slot = "$startHour-${startHour + 1}";
                return ChoiceChip(
                  label: Text(
                    slot,
                    style: GoogleFonts.poppins(
                      color: _selectedTimeSlotIndex == index
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  selected: _selectedTimeSlotIndex == index,
                  selectedColor: Colors.red,
                  backgroundColor: Colors.grey[200],
                  showCheckmark: true,
                  checkmarkColor: Colors.white,
                  onSelected: (val) {
                    setState(() {
                      _selectedTimeSlotIndex = index;
                    });
                  },
                );
              }),
            ),
            if (_selectedDateIndex != null &&
                _selectedTimeSlotIndex != null) ...[
              const SizedBox(height: 20),
              Text(
                "Select Payment Mode",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              RadioListTile<String>(
                value: "cash",
                groupValue: _selectedPaymentMode,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMode = value!;
                  });
                },
                title:
                    Text("Pay Cash", style: GoogleFonts.poppins(fontSize: 15)),
              ),
              RadioListTile<String>(
                value: "online",
                groupValue: _selectedPaymentMode,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMode = value!;
                  });
                },
                title: Text("Pay Online",
                    style: GoogleFonts.poppins(fontSize: 15)),
              ),
              if (_selectedPaymentMode.isNotEmpty) ...[
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Proceed with booking logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Proceeding with $_selectedPaymentMode payment"),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      "Proceed to Payment",
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ]
            ]
          ],
        ),
      ),
    );
  }

  Widget totalBill(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
