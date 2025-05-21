import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:garage/Screens/LoginScreen/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ComperhensiveServicing extends StatefulWidget {
  const ComperhensiveServicing({super.key});

  @override
  State createState() => _ComperhensiveServicingState();
}

class _ComperhensiveServicingState extends State {
  int activeIndex = 0;
  List<MyItem> items = [
    MyItem("img1", "assets/Service_Booking/service1.jpg"),
    MyItem("img2", "assets/Service_Booking/service2.jpg"),
    MyItem("img3", "assets/Service_Booking/service3.jpg"),
    MyItem("img4", "assets/Service_Booking/service4.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Standard Servicing",
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: items.length,
            options: CarouselOptions(
              height: 400,
              viewportFraction: 1,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final imgList = items[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 60,
                    ),
                    child: buildImage(imgList.path, index),
                  )
                ],
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 320, left: 150),
            child: buildIndicator(),
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        width: double.infinity,
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {},
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Rs.28,519/-",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  "Add to Cart",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildImage(String imgList, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          imgList,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: items.length,
      effect: const ExpandingDotsEffect(
        dotColor: Colors.black,
        dotHeight: 15,
        dotWidth: 15,
        activeDotColor: Colors.red,
      ),
    );
  }
}
