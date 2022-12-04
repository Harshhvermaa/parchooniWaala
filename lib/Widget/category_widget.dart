import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Models/category.dart';
import 'package:parchooni_waala/Screens/SubCategories.dart';

class CategoryWidget extends StatelessWidget {
  CategoriesModel sellerCategories;
  String phone;

  CategoryWidget({Key? key, required this.sellerCategories,required this.phone })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Get.to(SubCategories(
        phone: phone,
        categoryName: sellerCategories.category_name,
      )),
      onLongPress: () async {
        await FirebaseFirestore.instance
            .collection("Sellers")
            .doc(firebaseAuth.currentUser!.uid)
            .collection("Categories")
            .doc(sellerCategories.category_name)
            .delete()
            .then((value) async
            {
            print("Deleted from sellers acc");
            await FirebaseFirestore.instance
            .collection("Categories")
            .doc(sellerCategories.category_name)
            .delete()
            .then((value)async
            {
              print("Deleted from Categories Collection");
              await FirebaseStorage
              .instance
              .ref( "Categories/${ sellerCategories.category_name }" )
              .delete().then((value) => Get.snackbar("Deletion Completed","") );
            }).then((value) async
            {
            });
            });
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 12, top: 10, bottom: 20 ),
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
                      image: NetworkImage(
                          sellerCategories.category_image.toString()),
                    )),
                Text(
                  sellerCategories.category_name.toString(),
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
          Positioned(
            top: 0,
            right: 5,
            child: Stack(
              children: [
                Image(image: AssetImage("assets/discount.png"),height: 30,width: 30,),
                Positioned(
                  top: 7,
                  right: 5,
                  child: Text(
              sellerCategories.category_offer.toString() + "%",
              style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 13,
                  letterSpacing: -1,
                  fontWeight: FontWeight.w600),
            ),
                  )
              ],
            )
            )
        ],
      ),
    );
  }
}
