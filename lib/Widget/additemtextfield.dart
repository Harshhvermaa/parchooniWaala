import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class additemTextField extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
   additemTextField({Key? key , this.controller , this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, top: 15, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color:  Color(0xFFA25FFF) , width: 1 ),
                          // color: Color.fromARGB(255, 162, 95, 255),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: controller,
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 54, 54, 54),
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        cursorColor: Color(0xFFA25FFF),
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: InputBorder.none,
                          hintText: "$hintText",
                          hintStyle: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 186, 186, 186),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  );
  }
}