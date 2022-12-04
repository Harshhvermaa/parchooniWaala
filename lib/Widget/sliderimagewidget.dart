import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Models/category.dart';
import 'package:parchooni_waala/Models/sliderimage.dart';
import 'package:parchooni_waala/Screens/SubCategories.dart';

class sliderImageWidget extends StatelessWidget {
  sliderimgeModel imagemodel;

  sliderImageWidget({Key? key, required this.imagemodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onLongPress: () async {
        await FirebaseFirestore.instance
            .collection("Slider")
            .doc(imagemodel.SliderImageName)
            .delete();
      },
      child: Column(
        children: [
          
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 12, top: 5, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFA25FFF).withOpacity(0.2),
                        offset: Offset(3.0, 3.9), //(x,y)
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  width: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 100,
                          width: 200,
                          child: Image(
                            image: NetworkImage(
                              imagemodel.SliderImageUrl.toString(),
                            ),
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        imagemodel.SliderImageName.toString().length > 8
                            ? imagemodel.SliderImageName!.substring(0, 6) +
                                "..."
                            : imagemodel.SliderImageName.toString(),
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 1, 1, 1),
                            fontSize: 22,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   top: 0,
              //   right: 5,
              //   child: Stack(
              //     children: [
              //       Image(image: AssetImage("assets/discount.png"),height: 30,width: 30,),
              //       Positioned(
              //         top: 7,
              //         right: 5,
              //         child: Text(
              //     sellerCategories.category_offer.toString() + "%",
              //     style: GoogleFonts.poppins(
              //         color: Color.fromARGB(255, 255, 255, 255),
              //         fontSize: 13,
              //         letterSpacing: -1,
              //         fontWeight: FontWeight.w600),
              //   ),
              //         )
              //     ],
              //   )
              //   )
            ],
          ),
        ],
      ),
    );
  }
}
