import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khayalfit/widgets/imageslider.dart';
List<String> images = [
  'assets/images/1.jpeg',
  'assets/images/2.jpeg',
  'assets/images/3.jpg',
  'assets/images/4.jpg',
];
class ExerciseWithUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Theme.of(context).colorScheme.primary,
      
      child: Column(
        children: <Widget>[
          
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:  EdgeInsets.only(left: 8.0),
              child: Text(
                'Exercise with us',
                style: GoogleFonts.abrilFatface(
                  fontSize: 30,
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
            fontSize: 15,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          ),
        ),
        SizedBox(height: 20),
        ImageSlider(images: images),
        
  ]));
  }}
