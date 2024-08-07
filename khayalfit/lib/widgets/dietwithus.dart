import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khayalfit/widgets/imageslider.dart';
List<String> images = [
  'assets/images/khayal1.jpg',
  'assets/images/khayal2.jpg',
  'assets/images/khayal3.jpg',
  'assets/images/khayal4.jpg',
  'assets/images/khayal5.jpg',
];
class DietWithUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
       color: Theme.of(context).colorScheme.shadow,
      
      child: Column(
        children: <Widget>[
          
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:  EdgeInsets.only(left: 8.0),
              child: Text(
                'Diet with us',
                style: GoogleFonts.abrilFatface(
                  fontSize: (width>600)?40:30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:Text(
'At Khayalergy, we believe that maintaining a healthy diet should be easy and enjoyable! Our website offers a variety of simple, delicious recipes tailored to your dietary needs, With each recipe, we emphasize quick preparation times and mouthwatering flavors , our meals are designed to delight your taste buds and fit seamlessly into your lifestyle. In addition to, providing beautiful images and step-by-step instructions to guide you along the way. Join us at Khayalergy, where healthy eating is not just a goal, but a delightful experience!',
          style: GoogleFonts.roboto(
            fontSize:  (width>600)?25:15,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          ),
        ),
        SizedBox(height: 20),
        ImageSlider(images: images),
        
  ]));
  }}
