import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khayalfit/widgets/imageslider.dart';
List<String> images = [
  'assets/images/1.jpeg',
  'assets/images/2.jpeg',
  'assets/images/3.jpg',
  'assets/images/4.jpg',
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
'custmise your diet plan with us and get the best results. Our diet plans are designed by expert nutritionists to help you achieve your fitness goals. Whether you want to lose weight.',          
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
