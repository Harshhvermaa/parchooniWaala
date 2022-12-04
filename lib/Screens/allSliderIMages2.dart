import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parchooni_waala/Global/global.dart';
import 'package:parchooni_waala/Models/category.dart';
import 'package:parchooni_waala/Models/sliderimage.dart';
import 'package:parchooni_waala/Screens/add_category.dart';
import 'package:parchooni_waala/Screens/add_sliderimage.dart.dart';
import 'package:parchooni_waala/Screens/items.dart';
import 'package:parchooni_waala/Widget/category_widget.dart';
import 'package:parchooni_waala/Widget/appbar.dart';
import 'package:parchooni_waala/Widget/carouselSlider.dart';
import 'package:parchooni_waala/Widget/sliderimagewidget.dart';

import '../Widget/sliderimagewidget2.dart';
import 'addSliderImage2.dart';

class allSliderIMages2 extends StatefulWidget {
  allSliderIMages2({Key? key}) : super(key: key);

  @override
  State<allSliderIMages2> createState() => allSliderIMages2State();
}

class allSliderIMages2State extends State<allSliderIMages2> {
  String? location;

  Future fetchLocationFromFirebase() async {
    var userData = await FirebaseFirestore.instance
        .collection("Sellers")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    location = await userData.data()!["appbarAddress"];
    setState(() {});
  }

  Stream? slides;
  Stream? _queryDb() {
    slides = FirebaseFirestore.instance
        .collection("Slider2")
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
  }

  @override
  void initState() {
    // TODO: implement initState
    _queryDb();
    super.initState();
    // fetchLocationFromFirebase();
  }

  final PageController controller = PageController();

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
                  Appbar(
                      Address: sharedPreferences!.getString("appbarAddress")),
                  SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: StreamBuilder(
                        stream: slides,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<dynamic> slidesList = snapshot.data!.toList();
                            // print("gbdfd");
                            // print(  slidesList[ 0 ]  );
                            return CarouselSlider(
                              options: CarouselOptions(
                                height: MediaQuery.of(context).size.height * .3,
                                // aspectRatio: 16 / 8,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 2),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 500),
                                autoPlayCurve: Curves.decelerate,
                                // enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: slidesList.map((index) {
                                var url = index["SliderImageUrl"];
                                // print("$url");
                                // var data = slidesList[index];
                                // print(slidesList[index]);
                                // print(slidesList[index] + "dsf");
                                return Builder(builder: (BuildContext context) {
                                  return Container(
                                      height: 130,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(
                                          right: 12.0, top: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: NetworkImage(url),
                                            fit: BoxFit.cover),
                                      ));
                                });
                              }).toList(),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Slider2")
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    // print("${snapshot.data!.docs.length}");
                                    sliderimgeModel imagemodel =
                                        sliderimgeModel.toJson(
                                            snapshot.data!.docs[index].data());
                                    // print(imagemodel.SliderImageName);
                                    return Column(
                                      children: [
                                        sliderImageWidget2(
                                            imagemodel: imagemodel),
                                      ],
                                    );
                                  });
                            } else {
                              return LinearProgressIndicator();
                            }
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.055,
              child: ElevatedButton(
                onPressed: () async {
                  Get.to(addSliderImage2());
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

  _buildpage(Map data) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: SizedBox(
            child: Image.network(
              data["SliderImageUrl"],
              height: 100,
              width: 100,
            ),
          ),
        ));
  }
}
