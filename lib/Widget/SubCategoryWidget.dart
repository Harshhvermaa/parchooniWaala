import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Models/category.dart';
import 'package:parchooni_waala/Models/subcategory.dart';
import 'package:parchooni_waala/Screens/items.dart';

import '../Screens/SubCategories.dart';

class SubCategoryWidget extends StatelessWidget {
  String categoryName;
  subCategory subcategory;

  SubCategoryWidget(
      {Key? key, required this.subcategory, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 0, bottom: 15),
      child: InkWell(
        onTap: () => Get.to(Items(categoryName: categoryName , subCategoryName: subcategory.subcategory_name.toString()),),
        onLongPress: () async {
          await FirebaseFirestore.instance
            .collection("Sellers")
            .doc(firebaseAuth.currentUser!.uid)
            .collection("Categories")
            .doc(categoryName)
            .collection("subCategory")
            .doc(subcategory.subcategory_name.toString())
            .delete()
            .then((value)async
            {
              await FirebaseFirestore.instance
              .collection("Categories")
            .doc(categoryName)
            .collection("subCategory")
            .doc(subcategory.subcategory_name.toString())
            .delete()
            .then((value)async
            {
              await FirebaseFirestore.instance
              .collection("subCategory")
            .doc(subcategory.subcategory_name.toString())
            .delete()
            .then((value)async
            {
              await FirebaseStorage
                .instance
                .ref( "subCategories/${ subcategory.subcategory_name }" )
                .delete();
            });

            });
            });
        },
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
            children: [
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(
                    image: NetworkImage(subcategory.subcategory_image.toString()),
                  )),
              SizedBox(
                width: 20,
              ),
              Text(
                subcategory.subcategory_name.toString().length > 12
                    ? subcategory.subcategory_name.toString().substring(0, 12) + "..."
                    : subcategory.subcategory_name.toString(),
                style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 1, 1, 1),
                    fontSize: 22,
                    letterSpacing: -1,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
