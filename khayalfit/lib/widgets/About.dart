import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Container(
       color:Theme.of(context).colorScheme.shadow,
      
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
          child: Text( 'KhayalFit is a fitness app that helps you to stay fit and healthy. It provides you with a variety of exercises and diet plans to help you achieve your fitness goals. Our app is designed to be user-friendly and easy to use, so you can focus on your fitness journey without any distractions. Whether you are a beginner or an experienced fitness enthusiast, KhayalFit has something for everyone. So download our app today and start your fitness journey with us!',
          style: GoogleFonts.roboto(
            fontSize: (width>600)?25:15,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          ),
        ),
        
  ]));
  }}
