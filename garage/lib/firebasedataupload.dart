import "dart:developer";
import "dart:io";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:garage/Model/garage.dart";
import "package:garage/Model/item.dart";
import "package:garage/Providers/garage_provider.dart";
import "package:garage/Providers/login_data.dart";
import "package:garage/Screens/Home/garagehomepage.dart";
import "package:garage/Screens/Home/home_screen.dart";
import "package:garage/Screens/LoginScreen/otp_screen.dart";
import "package:garage/Screens/Profile/myprofilefirsttime.dart";
import "package:garage/Screens/Profile/profilescreen.dart";
import "package:garage/Screens/Profile/register_partner.dart";
import "package:garage/SharePreferencesFunction/shared_preferences_function.dart";
import "package:garage/navBar.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:provider/provider.dart";
import 'package:firebase_storage/firebase_storage.dart';

void uploadUserData(BuildContext context) async {
  Map<String, dynamic> data = {
    "name": context.read<LoginData>().name,
    "email": context.read<LoginData>().email,
    "dOB": context.read<LoginData>().dOB,
    "gender": context.read<LoginData>().gender,
    "vehicleInfo": {
      "company": context.read<CarInfo>().carCompany,
      "model": context.read<CarInfo>().carModel,
      "fuel": context.read<CarInfo>().carFuelType,
    }
  };
  FirebaseFirestore.instance
      .collection("Users")
      .doc(context.read<LoginData>().completeNumber)
      .set(data);
}

void sendOTP(BuildContext context) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: context.read<LoginData>().completeNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);
      context.read<Loader>().changeGetOtpLoader('off');
    },
    verificationFailed: (FirebaseAuthException e) {
      log("error:");
      // print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚠️${e.message}'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 3),
        ),
      );
      context.read<Loader>().changeGetOtpLoader('off');
    },
    codeSent: (String verificationId, int? forceResendingToken) {
      context.read<LoginData>().setVerificationId(verificationId);
      log(context.read<LoginData>().verificationId);
      log("otp sent");
      context.read<Loader>().changeGetOtpLoader('off');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const Otpscreen();
      }));
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      context.read<Loader>().changeGetOtpLoader('off');
    },
  );
}

void sumbitOTP(BuildContext context, otp) async {
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: context.read<LoginData>().verificationId, smsCode: otp);
  log(credential.verificationId.toString());
  try {
    log("otp is $otp");
    await FirebaseAuth.instance.signInWithCredential(credential);

    log("signin successfully");

    final docRef = FirebaseFirestore.instance
        .collection(
            context.read<LoginData>().loginType == 'user' ? 'Users' : 'Garage')
        .doc('+919665709491');
    try {
      DocumentSnapshot doc = await docRef.get();
      if (context.read<LoginData>().loginType == 'user') {
        if (doc.exists) {
          log('Document exists!');
          setLoginPreferences(context); //shared preference for login
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Navbar();
          }));
        } else {
          log('Document does not exist.');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MyprofileFirstTime();
          }));
        }
      } else {
        if (doc.exists) {
          log('Document exists!');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            setLoginPreferences(context); //shared preference for login
            return const Garagehomepage();
          }));
        } else {
          log('Document does not exist.');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const RegisterPartner();
          }));
        }
      }
    } catch (e) {
      log("error for doc");
    }
  } catch (e) {
    log(e.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }
  context.read<Loader>().changeSubmitOtpLoader(false);
}

void registerGarage(
    BuildContext context, Map<String, dynamic> data, List images) async {
  String completeNumber = context.read<LoginData>().completeNumber;
  List imageUrl = [];
  try {
    final docRef =
        FirebaseFirestore.instance.collection('Garages').doc(completeNumber);
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      log('Document exists!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Mobile number already used. Try with another number")),
      );
    } else {
      log('Document does not exist.');
      for (int i = 0; i < images.length; i++) {
        UploadTask uploadtask = FirebaseStorage.instance
            .ref()
            .child('GarageImages')
            .child(completeNumber)
            .child(completeNumber + i.toString())
            .putFile(images[i]);
        TaskSnapshot taskSnapshot = await uploadtask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrl.add(downloadUrl);
      }
      data['images'] = imageUrl;

      await FirebaseFirestore.instance
          .collection("Garages")
          .doc(completeNumber)
          .set(data); //context.read<LoginData>().completeNumber
      log('garage registerd on firebase');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Garage added Successfully!")),
      );
      setLoginPreferences(context); //shared preference for login

      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (context) =>const Navbar()),(Route<dynamic> route) => false,);

      Navigator.of(context).pop();
    }
  } catch (e) {
    log("error for doc");
  }
}

void uploadItemGlobal(InventoryItem item) async {
  DocumentReference<Map<String, dynamic>> data =
      await FirebaseFirestore.instance.collection('Global_inventory').add({});

//images
  UploadTask uploadtask = FirebaseStorage.instance
      .ref()
      .child('Global_inventory')
      .child(data.id)
      .putFile(item.image!);
  TaskSnapshot taskSnapshot = await uploadtask;
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();

  //all data

  Map<String, dynamic> itemData = {
    'id': data.id,
    'name': item.name,
    'description': item.description,
    'category': item.category,
    'price': item.price,
    'image': downloadUrl
  };

  //upload
  await FirebaseFirestore.instance
      .collection('Global_inventory')
      .doc(data.id)
      .set(itemData);
  log("local data uploaded successfully");
  log("global data uploaded successfully");
}

void uploadItemLocal(String completeNumber, InventoryItem item) async {
//get previous data of local inventory
  List localInventory = [];
  DocumentSnapshot<Map<String, dynamic>> prevData = await FirebaseFirestore
      .instance
      .collection("Garages")
      .doc(completeNumber)
      .get();
  try {
    localInventory = prevData['localInventory'];
  } catch (e) {
    log("error111 $e");
  }

  DocumentReference<Map<String, dynamic>> data =
      await FirebaseFirestore.instance.collection('Local_inventory').add({});

//images
  UploadTask uploadtask = FirebaseStorage.instance
      .ref()
      .child('Local_inventory')
      .child(data.id)
      .putFile(item.image!);
  TaskSnapshot taskSnapshot = await uploadtask;
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();

  //all data

  Map<String, dynamic> itemData = {
    'id': data.id,
    'name': item.name,
    'description': item.description,
    'category': item.category,
    'price': item.price,
    'image': downloadUrl
  };

  //upload
  await FirebaseFirestore.instance
      .collection('Local_inventory')
      .doc(data.id)
      .set(itemData);
  log('1');
  localInventory.add(data.id);
  log("2");
  await FirebaseFirestore.instance
      .collection('Garages')
      .doc(completeNumber)
      .update({"localInventory": localInventory});
  log("3");
  log("local data uploaded successfully");

  fetchInventoryData();
}

void fetchInventoryData() async {
  List localInventory = ["082k8AX9BeTACz9HePQy", "PgZA1ChxrqIkpj85mKwr"];
  String completeNumber = "+9665709490";

  // List allItems=[];
  Map<String, List> allItems = {
    "Battery": [],
    "AC": [],
    "Brake": [],
    "Clutch": [],
    "Tyre": [],
  };

  var globalData =
      await FirebaseFirestore.instance.collection("Global_inventory").get();
  var globalData1 = globalData.docs;
  for (int i = 0; i < globalData1.length; i++) {
    allItems[globalData1[i]['category']]!.add(globalData1[i].data());
  }

  for (int i = 0; i < localInventory.length; i++) {
    var localData = await FirebaseFirestore.instance
        .collection("Local_inventory")
        .doc(localInventory[i])
        .get();
    allItems[localData['category']]!.add(localData.data());
    // allItems.add(localData.data());
  }

  log("all items");
  print(allItems);
}
  Future addNewGarage(BuildContext context, List<File> images) async {
    TempGarage tempGarage = context.read<GarageProvider>().tempGarage!;
    String completeNumber = context.read<LoginData>().completeNumber;
    log("completenumber");
    log(completeNumber);
    List<String> imageUrl = [];

    try {
      final docRef =
          FirebaseFirestore.instance.collection('Garages').doc(completeNumber);
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        log('Document exists!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text("Mobile number already used. Try with another number")),
        );
      } else {
        try {
          // final FirebaseStorage storage = FirebaseStorage.instanceFor(
          //   bucket: 'automech-ca3b2.appspot.com',
          // );

          // for (int i = 0; i < tempGarage.images.length; i++) {

          //   log("1");
          //   print(tempGarage.images[i].toString());
          //   UploadTask uploadtask = storage
          //       .ref()
          //       .child('Inventory')
          //       .child("$completeNumber${i.toString()}")
          //       .putFile(tempGarage.images[i]);
          //       log("2  : $uploadtask");
          //   TaskSnapshot taskSnapshot = await uploadtask;
          //   log("3");
          //   String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          //   log("4");
          //   imageUrl.add(downloadUrl);
          // }

          for (int i = 0; i < tempGarage.images.length; i++) {
            UploadTask uploadtask = FirebaseStorage.instance
                .ref()
                .child('Inventory')
                .child(completeNumber)
                .child(completeNumber + i.toString())
                .putFile(images[i]);
            TaskSnapshot taskSnapshot = await uploadtask;
            String downloadUrl = await taskSnapshot.ref.getDownloadURL();
            imageUrl.add(downloadUrl);
          }
        } catch (e) {
          log("error to upload garage images");
          log("$e");
        }

        Map<String, dynamic> data = {
          "name": tempGarage.name,
          "address": tempGarage.address,
          "lat": tempGarage.lat,
          "lng": tempGarage.lng,
          "phone": tempGarage.phone,
          "images": imageUrl,
          "openingHours": tempGarage.openingHours,
        };

        await FirebaseFirestore.instance
            .collection("Garages")
            .doc(completeNumber)
            .set(data); //context.read<LoginData>().completeNumber
        log('garage registerd on firebase');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Garage added Successfully!")),
        );

        // context.read<GarageProvider>().addGarage(
        //       tempGarage.name,
        //       tempGarage.lat,
        //       tempGarage.lng,
        //       imageUrl,
        //       tempGarage.address,
        //       tempGarage.phone,
        //       tempGarage.openingHours,
        //       [],
        //     );

        setLoginPreferences(context); //shared preference for login

        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (context) =>const Navbar()),(Route<dynamic> route) => false,);

        // Navigator.of(context).pop();
      }
    } catch (e) {
      log("error for doc");
    }
  }

