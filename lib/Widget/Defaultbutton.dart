import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Screens/SubCategories.dart';
import 'package:parchooni_waala/Screens/categories.dart';

class defaultButton1 extends StatelessWidget {
  String? categoryName;
  String phone;
  defaultButton1({Key? key,this.categoryName , required this.phone }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton
      (
      onPressed: ()
      {
        Get.to(Categories(categoryName: categoryName,phone: phone,));
      }, 
      child: Text("Nope",
      style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w400),),
      style: ButtonStyle
      (
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        side: MaterialStateProperty.all( BorderSide(color: Color(0xFFA25FFF),width: 1)),
      ),
      );
  }
}