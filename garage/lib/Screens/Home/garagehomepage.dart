import 'package:flutter/material.dart';
import 'package:garage/Providers/login_data.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';







class Garagehomepage extends StatefulWidget {
  const Garagehomepage({super.key});
  @override
  State createState() => _Garagehomepage();
}

class _Garagehomepage extends State {
  bool buttonClicked=false;
  List _imageList=[];
Future getGarageImages() async{
  DocumentSnapshot _data=await FirebaseFirestore.instance.collection('Garages').doc(context.read<LoginData>().completeNumber).get();
  _imageList=_data['images'];

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Profile",
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Garage Homepage"),
              buttonClicked?ListView.builder(
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
               return Image.network(_imageList[index]);
                 },
              itemCount: _imageList.length,):
              ElevatedButton(
                onPressed: () async{
                  await getGarageImages();
                  buttonClicked=true;
                  setState(() {
                  });
                } ,
               child: const Text("see images")),
              
            ],
          ),
        ),
      )
    );
  }
}
