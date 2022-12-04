import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Screens/add_sliderimage.dart.dart';
import 'package:parchooni_waala/Screens/allsliderimages.dart';
import 'package:parchooni_waala/Screens/mobilenumber_screen.dart';

import '../Screens/allSliderIMages2.dart';

class Appbar extends StatefulWidget {
  String? Address;

  Appbar({Key? key, this.Address}) : super(key: key);

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(color: Color(0xFFA25FFF)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, top: 35, bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.Address.toString(),
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 251, 251, 251),
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Image(
                      image: AssetImage("assets/user.png"),
                      color: Colors.white,
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          firebaseAuth.signOut();
                          Get.offAll(() => MobileNumber());
                        },
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, top: 15, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 186, 186, 186),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                      child: TextField(
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 49, 49, 49),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    cursorColor: Color.fromARGB(255, 49, 49, 49),
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 186, 186, 186),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ))
                ],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.048,
              child: ElevatedButton(
                onPressed: () async 
                {
                  Get.to(() => allSliderIMages());
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 255, 255, 255)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: Text(
                  "Carousel Slider",
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 186, 186, 186),
                      fontSize: 15,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.048,
              child: ElevatedButton(
                onPressed: () async 
                {
                  Get.to(() => allSliderIMages2());
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 255, 255, 255)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: Text(
                  "Carousel Slider 2 ",
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 186, 186, 186),
                      fontSize: 15,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
