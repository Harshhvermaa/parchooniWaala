import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Models/items.dart';
import 'package:parchooni_waala/Screens/OtpScreen.dart';
import 'package:parchooni_waala/Screens/SubCategories.dart';
import 'package:parchooni_waala/Screens/add_subcategory.dart';
import 'package:parchooni_waala/Screens/categories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/mobilenumber_screen.dart';
import 'firebase_options.dart';

Future<void> main(  )
 async
{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await
   Firebase.initializeApp
  (
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp
    (
      getPages: [
        // GetPage(name: "addsubCategory", page: () => Addsubcategory()),   
        // GetPage(name: "subCategory", page: SubCategories(categoryName: ,),)
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
      home: firebaseAuth.currentUser == null ? MobileNumber() : Categories(),
    );
  }
}