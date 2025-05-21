import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garage/Model/cart_model.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:garage/Providers/login_data.dart';
import 'package:garage/Providers/user_provider.dart';
import 'package:garage/Screens/CarCompany/CarCompany.dart';
import 'package:garage/Screens/CarCompany/FuelType.dart';
import 'package:garage/Screens/CarCompany/ManualEntry.dart';
import 'package:garage/Screens/Home/userhomepage.dart';
import 'package:garage/Screens/Inventory/acPage.dart';
import 'package:garage/Screens/Inventory/add_item.dart';
import 'package:garage/Screens/Inventory/batteryPage.dart';
import 'package:garage/Screens/Inventory/brakePage.dart';
import 'package:garage/Screens/Inventory/clutchPage.dart';
import 'package:garage/Screens/Inventory/glassPage.dart';
import 'package:garage/Screens/Inventory/inventory.dart';
import 'package:garage/Screens/Inventory/lightPage.dart';
import 'package:garage/Screens/Inventory/suspensionPage.dart';
import 'package:garage/Screens/Inventory/tyrePage.dart';
import 'package:garage/Screens/LoginScreen/login.dart';
import 'package:garage/Screens/LoginScreen/otp_screen.dart';
import 'package:garage/Screens/MapScreen/MapScreen.dart';
import 'package:garage/Screens/MapScreen/newmap.dart';
import 'package:garage/Screens/Profile/myprofile.dart';
import 'package:garage/Screens/Profile/profilescreen.dart';
import 'package:garage/Screens/Profile/register_partner.dart';
import 'package:garage/Screens/ServiceBooking/my_cart.dart';
import 'package:garage/Screens/ServiceBooking/service_booking.dart';
import 'package:garage/Screens/SplashScreen/SplashScreen.dart';
import 'package:garage/Screens/CarCompany/modelSelection.dart';
import 'package:garage/SharePreferencesFunction/shared_preferences_function.dart';
import 'package:garage/navBar.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options:const FirebaseOptions(apiKey: "AIzaSyBJp_EviA7gE9MCsv2yuaptfgxcSKIsqKE", appId: "1:800570586689:android:4ff34861306367c4f9f8c0", messagingSenderId: "800570586689", projectId: "automech-ca3b2"));
 bool isPreviousLogin= await isAccountLogined();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GarageProvider()),
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LoginData()),
        ChangeNotifierProvider(create: (_) => CarInfo()),
        ChangeNotifierProvider(create: (_) => Loader()),
      ],
      child: MainApp(isPreviousLogin),
    ),
  );
}

class MainApp extends StatelessWidget {
    final bool isPreviousLogin;

  const MainApp(this.isPreviousLogin,{super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: isPreviousLogin ?const Navbar() :const SplashScreen(),
      home: Navbar(),
    );
  }
}
