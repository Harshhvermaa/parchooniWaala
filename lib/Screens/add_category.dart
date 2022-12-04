import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parchooni_waala/Firestore/firestore.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Screens/categories.dart';

class Addcategory extends StatefulWidget {
  const Addcategory({Key? key}) : super(key: key);

  @override
  State<Addcategory> createState() => _AddcategoryState();
}

class _AddcategoryState extends State<Addcategory> {
  XFile? imageXFile;
  var imageUrl;
  ImagePicker _picker = ImagePicker();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _offerController = TextEditingController();

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }


  Addcategories() async {
    // UploadImage and Fetch image URL

    // Add data in userCategory or Catogory collection

    await FirebaseFirestore.instance
        .collection("Sellers")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Categories")
        .doc(_categoryController.text)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        Get.defaultDialog(
            title: "",
            content: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text("Playlist Already Created")
              ],
            ),);
      } else {
        await storageService()
            .uploadimage(_categoryController.text, imageXFile!.path,"Categories");
        var data = await storageService().fetchImage(_categoryController.text,"Categories");
        imageUrl = data.toString();
        print(imageUrl.toString());

        await FirebaseFirestore.instance
            .collection("Sellers")
            .doc(firebaseAuth.currentUser!.uid)
            .collection("Categories")
            .doc(_categoryController.text)
            .set({
              "Available" : true,
          "category_name": _categoryController.text,
          "category_offer": _offerController.text,
          "category_image": imageUrl
        }).then((value) async {
          await FirebaseFirestore.instance
              .collection("Categories")
              .doc(_categoryController.text)
              .set({
                "Available" : true,
            "category_name": _categoryController.text,
            "category_offer": _offerController.text,
            "category_image": imageUrl
          });
        });
        Get.to( Categories() );
        Get.defaultDialog(
                    title: "Your Category Added Successfully",
                    content: Column(
                      children: [
                        Image(
                          image: AssetImage("assets/success.png"),
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("")
                      ],
                    ),
                  );
      }
    });
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
      if (_categoryController.text.isEmpty  ) {
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
      }
      else{
        if (_offerController.text.isEmpty  ) {
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
              Text("Please fill Offer fields ")
            ],
          ),
        );
      }else{
        Addcategories();
      }
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
                            child: Image(
                              image: FileImage(
                                File(
                                  imageXFile!.path,
                                ),
                              ),
                              // fit: BoxFit.cover,
                              height: 317,
                              width: 216,
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
                        controller: _categoryController,
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: InputBorder.none,
                          hintText: "Name of Category",
                          hintStyle: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 186, 186, 186),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
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
                        controller: _offerController,
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: InputBorder.none,
                          hintText: "category_offer",
                          hintStyle: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 186, 186, 186),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )
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
                  "Add Category",
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
