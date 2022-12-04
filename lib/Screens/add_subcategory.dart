import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parchooni_waala/Firestore/firestore.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Screens/SubCategories.dart';
import 'package:parchooni_waala/Screens/categories.dart';

class Addsubcategory extends StatefulWidget {
  String? category_name;
  Addsubcategory({Key? key, this.category_name}) : super(key: key);

  @override
  State<Addsubcategory> createState() => _AddsubcategoryState();
}

class _AddsubcategoryState extends State<Addsubcategory> {
  final focusNode = FocusNode();
  XFile? imageXFile;
  var imageUrl;
  ImagePicker _picker = ImagePicker();
  TextEditingController _subCategory = TextEditingController();
  TextEditingController __subCategoryofferController = TextEditingController();

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
        .doc(_subCategory.text)
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
          ),
        );
      } else {
        await storageService()
            .uploadimage(_subCategory.text, imageXFile!.path, "subCategories");
        var data = await storageService()
            .fetchImage(_subCategory.text, "subCategories");
        imageUrl = data.toString();
        print(imageUrl.toString());

        await FirebaseFirestore.instance
            .collection("Sellers")
            .doc(firebaseAuth.currentUser!.uid)
            .collection("Categories")
            .doc(widget.category_name)
            .collection("subCategory")
            .doc(_subCategory.text)
            .set({
              "Available" : true,
          "subcategory_name": _subCategory.text,
          "subcategory_offer": _subCategory.text,
          "subcategory_image": imageUrl
        }).then((value) async {
          await FirebaseFirestore.instance
              .collection("Categories")
              .doc(widget.category_name)
              .collection("subCategory")
              .doc(_subCategory.text)
              .set({
                "Available" : true,
            "subcategory_name": _subCategory.text,
            "subcategory_offer": _subCategory.text,
            "subcategory_image": imageUrl
          }).then((value) async {
            await FirebaseFirestore.instance
                .collection("subCategory")
                .doc(_subCategory.text)
                .set({
                  "Available" : true,
              "subcategory_name": _subCategory.text,
              "subcategory_offer": _subCategory.text,
              "subcategory_image": imageUrl
            });
          });
        });
      }
    });
    Get.defaultDialog(
                    title: "Your sub_category\n Added Successfully",
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
      if (_subCategory.text.isEmpty) {
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
              Text("Please fill subCategoryName fields ")
            ],
          ),
        );
      } else {
        if (__subCategoryofferController.text.isEmpty) {
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
        } else {
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
                        controller: _subCategory,
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: InputBorder.none,
                          hintText: "Name of Sub-Category",
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
                        controller: __subCategoryofferController,
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: InputBorder.none,
                          hintText: "subcategory_offer",
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
                  FocusManager.instance.primaryFocus?.unfocus();
                  
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFA25FFF)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
                child: Text(
                  "Add subCategory",
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
