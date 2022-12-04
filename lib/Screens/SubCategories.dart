import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Models/subcategory.dart';
import 'package:parchooni_waala/Screens/add_subcategory.dart';
import 'package:parchooni_waala/Screens/add_item.dart';
import 'package:parchooni_waala/Widget/SubCategoryWidget.dart';
import 'package:parchooni_waala/Widget/simpleAppbar.dart';

class SubCategories extends StatefulWidget {
  String? categoryName;
  String? phone;
  SubCategories({Key? key, this.categoryName, this.phone}) : super(key: key);

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                children: [
                  Simpleappbar(
                    text: widget.categoryName,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Sellers")
                          .doc(firebaseAuth.currentUser!.uid)
                          .collection("Categories")
                          .doc(widget.categoryName)
                          .collection("subCategory")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                subCategory subcategory = subCategory.fromJson(
                                    snapshot.data!.docs[index].data());
                                return SubCategoryWidget(
                                  subcategory: subcategory,
                                  categoryName: widget.categoryName.toString(),
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
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
                  Get.to(
                    () => Addsubcategory(
                      // phone: widget.phone.toString(),
                      category_name: widget.categoryName.toString(),
                    ),
                  );
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFA25FFF)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
                child: Text(
                  "Add Sub_category",
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
