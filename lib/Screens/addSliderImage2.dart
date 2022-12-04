import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parchooni_waala/Firestore/firestore.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Screens/allSliderIMages2.dart';
import 'package:parchooni_waala/Screens/allsliderimages.dart';
import 'package:parchooni_waala/Screens/categories.dart';

class addSliderImage2 extends StatefulWidget {
  const addSliderImage2({Key? key}) : super(key: key);

  @override
  State<addSliderImage2> createState() => addSliderImage2State();
}

class addSliderImage2State extends State<addSliderImage2> {
  XFile? imageXFile;
  var imageUrl;
  ImagePicker _picker = ImagePicker();
  TextEditingController _sliderImageName = TextEditingController();
  // TextEditingController _offerController = TextEditingController();

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }


  Addcategories() async {
    // UploadImage and Fetch image URL

    // Add data in userCategory or Catogory collection

    await storageService().uploadimage("${_sliderImageName.text}", imageXFile!.path.toString(), "Slider2" );
    var data = await storageService().fetchImage("${_sliderImageName.text}", "Slider2");
    setState(() {
      imageUrl = data.toString();
    });
    await FirebaseFirestore
    .instance
    .collection("Slider2")
    .doc(_sliderImageName.text)
    .set(
      {
        "SliderImageUrl" : imageUrl,
        "SliderImageName" : _sliderImageName.text
      }
    );
    _sliderImageName.clear();
    Get.to(allSliderIMages2());
  }

  Validation() async {
    if (imageXFile == null) {
      Get.defaultDialog(
          title: "",
          content: Column(
            children: [
              Image(
                image: AssetImage("assets/warning.png"),
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 15,
              ),
              Text("Please choose an image")
            ],
          ));
    } else {
      if (_sliderImageName.text.isEmpty  ) {
        Get.defaultDialog(
          title: "",
          content: Column(
            children: [
              Image(
                image: AssetImage("assets/warning.png"),
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 15,
              ),
              Text("Please fill CategoryName fields ")
            ],
          ),
        );
      }else{
        Addcategories();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ListView(
                children: [
                  SizedBox(height: 30,),
                  SizedBox(
                    child: imageXFile == null
                        ? InkWell(
                            onTap: () async {
                              await _getImage();
                            },
                            child: Image(
                              image: AssetImage("assets/addimage.png"),
                            ))
                        : InkWell(
                            onTap: () async {
                              await _getImage();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: FileImage(
                                  File(
                                    imageXFile!.path,
                                  ),
                                ),
                                fit: BoxFit.cover,
                                height: 250,
                                width: double.infinity,
                              ),
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, top: 15, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 162, 95, 255),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: _sliderImageName,
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: InputBorder.none,
                          hintText: "Name Slider Image",
                          hintStyle: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 186, 186, 186),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25),
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.055,
              child: ElevatedButton(
                onPressed: () async {
                  Validation();
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFA25FFF)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
                child: Text(
                  "Add Image To Slider",
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 255, 255, 255),
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
