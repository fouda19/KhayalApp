import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 34, 34, 34), Color.fromARGB(255, 57, 56, 56)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
       //color:Theme.of(context).colorScheme.primary,
      
      child: Column(
        children: <Widget>[
          
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:  EdgeInsets.only(left: 8.0),
              child: Text(
                'About Us',
                style: GoogleFonts.abrilFatface(
                  fontSize: (width>600)?40:30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text( 'Khayalergy, founded by a natural athlete with over eight years of experience in science-based training and competed at the World Natural Bodybuilding Federation (WNBF),Khayalergy is a platform that provides personalized insights into your Basal Metabolic Rate (BMR) and daily caloric needs, enabling you to make informed choices that align with your fitness goals. They offer a comprehensive platform with easy-to-follow instructions, curated with delicious foods and images, and are dedicated to making fitness a lifestyle, not a chore.Join us in transforming your fitness goals into reality by following our guidance, enjoying the flavors, and witnessing your transformation into the best version of yourself.',
          style: GoogleFonts.bebasNeue(
            fontSize: (width>600)?25:18,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          ),
        ),
        
  ]));
  }}
