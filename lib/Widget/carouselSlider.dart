import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class carousel extends StatelessWidget {
  const carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final items = 
    [
      "assets/1.jpg",
      "assets/2.jpg",
      "assets/3.jpg",
    ];

    return CarouselSlider
    (
      items: items.map(( index ) 
      {
         return Padding(
           padding: const EdgeInsets.all(4.0),
           child: Container(
            decoration: BoxDecoration
            (
              image: DecorationImage(image: AssetImage(index),fit: BoxFit.cover ),
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black
            ),
        ),
         );
      }).toList(), 
      options: CarouselOptions(
        aspectRatio: 22/10,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(seconds: 3),

      )
    );
  }
}