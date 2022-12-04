import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Models/category.dart';
import 'package:parchooni_waala/Screens/add_category.dart';
import 'package:parchooni_waala/Widget/category_widget.dart';
import 'package:parchooni_waala/Widget/appbar.dart';
import 'package:parchooni_waala/Widget/carouselSlider.dart';

class Categories extends StatefulWidget {
  String? phone;
  String? currentUseruid;
   Categories({Key? key ,this.currentUseruid, this.phone, String? categoryName}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}


class _CategoriesState extends State<Categories> {

String? location;

Future fetchLocationFromFirebase() async
{
  print("dfsdf");
  var userData = await FirebaseFirestore.
   instance
   .collection("Sellers")
   .doc(firebaseAuth.currentUser!.uid)
   .get();

  location = await userData.data()!["appbarAddress"];
  setState(() {
    
  });
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchLocationFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;    
    return Scaffold
    (
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                children: [
                  Appbar( Address: sharedPreferences!.getString("appbarAddress") ),
                  Expanded(
                    child: SizedBox(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore
                        .instance
                        .collection("Sellers")
                        .doc(firebaseAuth.currentUser!.uid)
                        .collection("Categories")
                        .snapshots(),
                        builder: (context , AsyncSnapshot snapshot)
                        {
                          if (snapshot.hasData)
                          {
                            
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,  
                                itemBuilder: (context , index)
                                {
                                  print("${snapshot.data.docs.length}");
                                  CategoriesModel categories = CategoriesModel.fromJson( snapshot.data.docs[index].data());
                                  return CategoryWidget(sellerCategories: categories,phone: widget.phone.toString(),);
                                }
                                );
                          }
                          else
                          {
                            return LinearProgressIndicator();
                          }
                        }
                        ),
                    ),
                  )
                ],
              ),
            ),
          ),
          
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Container(
                width: double.infinity,
                height: screenHeight * 0.055,
                child: ElevatedButton(
                  onPressed: () async 
                  {
                      Get.to(Addcategory());
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