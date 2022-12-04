import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Simpleappbar extends StatelessWidget {
  String? text;
  Simpleappbar({Key? key , this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;        
    return Container(
      height: screenHeight * 0.1,
      width: screenWidth,
      decoration: BoxDecoration
      (
        color:Color(0xFFA25FFF)
      ),
      child: Column(
        children: [
          SizedBox(height: screenHeight*0.05,),
          Text( text.toString(),
          style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 247, 247, 247),
                    fontSize: 24,
                    letterSpacing: -1,
                    fontWeight: FontWeight.w600), )
        ],
      ),
    );
  }
}