import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khayalfit/widgets/imageslider.dart';
List<String> images = [
  'assets/images/khayal2.jpg',
  'assets/images/khayal3.jpg',
  'assets/images/khayal4.jpg',
  'assets/images/khayal6.jpg',
  'assets/images/khayal7.jpg',

];
class ExerciseWithUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 34, 34, 34), Color.fromARGB(255, 57, 56, 56)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
       //color: Theme.of(context).colorScheme.primary,
      
      child: Column(
        children: <Widget>[
          
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:  EdgeInsets.only(left: 8.0),
              child: Text(
                'Exercise with us',
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
          style: GoogleFonts.bebasNeue(
            fontSize: (width>600)?25:18,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          ),
        ),
        SizedBox(height: 20),
        ImageSlider(images: images),
        
  ]));
  }}
