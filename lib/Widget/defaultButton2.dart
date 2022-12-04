import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Screens/SubCategories.dart';
import 'package:parchooni_waala/Screens/categories.dart';

class defaultButton2 extends StatelessWidget {
  String phone;
  String categoryName;  
  defaultButton2({Key? key,required this.phone,required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton
      (
      onPressed: ()
      {
        print(phone);
        print("dfsdfd");
        print(categoryName);
        Get.to(SubCategories( categoryName: categoryName ,phone: phone,));
      }, 
      child: Text("Yeah",
      style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 15,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500),),
      style: ButtonStyle
      (
        backgroundColor: MaterialStateProperty.all(Color(0xFFA25FFF)),
        
        
      ),
      );
  }
}