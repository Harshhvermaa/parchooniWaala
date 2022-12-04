import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Models/items.dart';
import 'package:parchooni_waala/Models/subcategory.dart';
import 'package:parchooni_waala/Screens/add_subcategory.dart';
import 'package:parchooni_waala/Screens/add_item.dart';
import 'package:parchooni_waala/Widget/SubCategoryWidget.dart';
import 'package:parchooni_waala/Widget/itemswidget.dart';
import 'package:parchooni_waala/Widget/simpleAppbar.dart';

class Items extends StatefulWidget {
  String? categoryName;
  String? subCategoryName;

  Items({Key? key, this.categoryName, this.subCategoryName}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
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
                    text: widget.subCategoryName,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Sellers")
                          .doc(firebaseAuth.currentUser!.uid)
                          .collection("Categories")
                          .doc(widget.categoryName)
                          .collection("subCategory")
                          .doc(widget.subCategoryName)
                          .collection("Items")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                ItemsModel itemModel = ItemsModel.fromJson(
                                    snapshot.data!.docs[index].data());
                                return itemWidget(
                                  itemModel: itemModel,
                                  categoryname: widget.categoryName,
                                  subCategoryName: widget.subCategoryName,
                                  itemName: widget.categoryName.toString(),
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
                  Get.to(() => AddItem(
                        categoryname: widget.categoryName,
                        subCategoryName: widget.subCategoryName,
                      ));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFA25FFF)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
                child: Text(
                  "Add items to ${widget.subCategoryName}",
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
