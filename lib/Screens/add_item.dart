
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:parchooni_waala/Firestore/firestore.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Screens/SubCategories.dart';
import 'package:parchooni_waala/Screens/categories.dart';
import 'package:parchooni_waala/Widget/additemtextfield.dart';
import 'package:parchooni_waala/Widget/simpleAppbar.dart';

class AddItem extends StatefulWidget {
  String? categoryname;
  String? subCategoryName;
  AddItem({Key? key, this.categoryname, this.subCategoryName})
      : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  XFile? imageXFile;
  String? imageUrl;
  String final_price = "User price";
  ImagePicker _picker = ImagePicker();
  

  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemWeightController = TextEditingController();
  TextEditingController _weightUnit = TextEditingController();
  TextEditingController _userpriceController = TextEditingController();
  TextEditingController _adminpriceController = TextEditingController();
  TextEditingController _cutpriceController = TextEditingController();
  TextEditingController _offerController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _trending = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  addItems() async {
    // Get.defaultDialog(
    //   title: "",
    //   content: Column(
    //     children: [
    //       CircularProgressIndicator(),
    //       SizedBox(
    //         height: 15,
    //       ),
    //       Text("Adding item")
    //     ],
    //   ),
    // );
    // ADD ITEM TO USER

    await storageService()
        .uploadimage(_itemNameController.text, imageXFile!.path, "Items");
    var data =
        await storageService().fetchImage(_itemNameController.text, "Items");
    setState(() {
      imageUrl = data.toString();
    });
    print("IMAGE UPLOADED");
    await FirebaseFirestore.instance
        .collection("Sellers")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Categories")
        .doc(widget.categoryname)
        .collection("subCategory")
        .doc(widget.subCategoryName)
        .collection("Items")
        .doc(_itemNameController.text)
        .set({
      "Available": true,
      "Item_Name": _itemNameController.text.toString(),
      "Item_picurl": imageUrl.toString(),
      "Item_Weight": int.parse(_itemWeightController.text),
      "Item_wunit": _weightUnit.text,
      "AddedOrNot": false,
      "Date":DateTime.now(),
      "Trending" :  _trending.text,
      "Item_userPrice": int.parse(_userpriceController.text),
      "Item_adminPrice": int.parse(_adminpriceController.text),
      "Item_cutPrice": int.parse(_cutpriceController.text),
      "Item_offer": int.parse(_offerController.text),
      "Item_quantity": int.parse(_quantityController.text),
      "Description": _descriptionController.text.toString()
    }).then((value) async {
      print("ADDED ITEM TO SELLER COLLECTION");
      // ADD ITEM TO CATEGORY COLLECTION

      await FirebaseFirestore.instance
          .collection("Categories")
          .doc(widget.categoryname)
          .collection("subCategory")
          .doc(widget.subCategoryName)
          .collection("Items")
          .doc(_itemNameController.text)
          .set({
        "Available": true,
        "Item_Name": _itemNameController.text.toString(),
        "Item_picurl": imageUrl,
        "Item_Weight": int.parse(_itemWeightController.text),
        "Item_wunit": _weightUnit.text,
        "AddedOrNot": false,
        "Trending" : _trending.text,
        "Date":DateTime.now(),
        "Item_userPrice": int.parse(_userpriceController.text),
        "Item_adminPrice": int.parse(_adminpriceController.text),
        "Item_cutPrice": int.parse(_cutpriceController.text),
        "Item_offer": int.parse(_offerController.text),
        "Item_quantity": int.parse(_quantityController.text),
        "Description": _descriptionController.text.toString()
      }).then((value) async {
        print("ADDED ITEM TO CATEGORY COLLECTION");
        // ADD ITEM TO iTEMS COLLECTION

        await FirebaseFirestore.instance
            .collection("Items")
            .doc(_itemNameController.text)
            .set({
          "Available": true,
          "Item_Name": _itemNameController.text.toString(),
          "Item_picurl": imageUrl,
          "Item_Weight": int.parse(_itemWeightController.text),
          "Item_wunit": _weightUnit.text,
          "AddedOrNot": false,
          "Trending" : _trending.text,
          "Date":DateTime.now(),
          "Item_userPrice": int.parse(_userpriceController.text),
          "Item_adminPrice": int.parse(_adminpriceController.text),
          "Item_cutPrice": int.parse(_cutpriceController.text),
          "Item_offer": int.parse(_offerController.text),
          "Item_quantity": int.parse(_quantityController.text),
          "Description": _descriptionController.text.toString()
        });
      }).then((value) async {
        print("ADDED ITEM TO ITEMS COLLECTION");
        await FirebaseFirestore.instance
            .collection("subCategory")
            .doc(widget.subCategoryName)
            .collection("Items")
            .doc(_itemNameController.text)
            .set({
          "Available": true,
          "Item_Name": _itemNameController.text.toString(),
          "Item_picurl": imageUrl,
          "Trending" : _trending.text,
          "Item_Weight": int.parse(_itemWeightController.text),
          "Item_wunit": _weightUnit.text,
          "AddedOrNot": false,
          "Date":DateTime.now(),
          "Item_userPrice": int.parse(_userpriceController.text),
          "Item_adminPrice": int.parse(_adminpriceController.text),
          "Item_cutPrice": int.parse(_cutpriceController.text),
          "Item_offer": int.parse(_offerController.text),
          "Item_quantity": int.parse(_quantityController.text),
          "Description": _descriptionController.text.toString()
        }).then((value) => print("ADDED ITEM TO SUBCATEGORY COLLECTION"));
      });
    });
  }

  clearcontrollers() {
    _itemNameController.clear();
    _itemWeightController.clear();
    _weightUnit.clear();
    _userpriceController.clear();
    _adminpriceController.clear();
    _cutpriceController.clear();
    _offerController.clear();
    _quantityController.clear();
    _descriptionController.clear();
    Get.defaultDialog(
      title: "Your item Added Successfully",
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

  validation() async {
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
        ),
      );
    } else {
      if (_itemNameController.text.isEmpty &&
          _itemWeightController.text.isEmpty &&
          _userpriceController.text.isEmpty &&
          _adminpriceController.text.isEmpty &&
          _cutpriceController.text.isEmpty &&
          _offerController.text.isEmpty &&
          _quantityController.text.isEmpty &&
          _descriptionController.text.isEmpty) {
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
              Text("Fill All the fields")
            ],
          ),
        );
      } else {
        await addItems();
        clearcontrollers();
      }
    }
  }

  onEditingComplete() {
    int price = int.parse(_cutpriceController.text);
    int offer = int.parse(_offerController.text);
    var percent = price * offer / 100;
    var demofinalPrice = price - percent;
    setState(() {
      final_price = demofinalPrice.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  children: [
                    Simpleappbar(
                      text: widget.subCategoryName,
                    ),
                    SizedBox(
                      height: 317,
                      width: 216,
                      child: imageXFile == null
                          ? InkWell(
                              onTap: () async {
                                await _getImage();
                              },
                              child: Image(
                                image: AssetImage("assets/addimage.png"),
                              ),
                            )
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
                    additemTextField(
                      controller: _itemNameController,
                      hintText: "Item Name",
                    ),
                    additemTextField(
                      controller: _cutpriceController,
                      hintText: "Cut price",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 15, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFFA25FFF), width: 1),
                            // color: Color.fromARGB(255, 162, 95, 255),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          onEditingComplete: onEditingComplete,
                          controller: _offerController,
                          style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 54, 54, 54),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          cursorColor: Color(0xFFA25FFF),
                          cursorWidth: 1,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            border: InputBorder.none,
                            hintText: "Offer",
                            hintStyle: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 186, 186, 186),
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    additemTextField(
                      controller: _userpriceController,
                      hintText: final_price,
                    ),
                    
                    additemTextField(
                      controller: _trending,
                      hintText: "Trending",
                    ),

                    additemTextField(
                      controller: _adminpriceController,
                      hintText: "Admin Price",
                    ),
                    additemTextField(
                      controller: _itemWeightController,
                      hintText: "Weight",
                    ),
                    additemTextField(
                      controller: _weightUnit,
                      hintText: "Kg/G/litre",
                    ),
                    additemTextField(
                      controller: _quantityController,
                      hintText: "Quantity",
                    ),
                    additemTextField(
                      controller: _descriptionController,
                      hintText: "Description",
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 5, bottom: 13),
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.055,
              child: ElevatedButton(
                onPressed: () async {
                  validation();
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFA25FFF)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
                child: Text(
                  "Add Item to ${widget.subCategoryName}",
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: screenWidth > 300 ? 15 : 8,
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
