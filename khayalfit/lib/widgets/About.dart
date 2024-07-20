import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Color.fromARGB(255, 0, 0, 0),
      
      child: Column(
        children: <Widget>[
          
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:  EdgeInsets.only(left: 8.0),
              child: Text(
                'About Us',
                style: GoogleFonts.abrilFatface(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ),
          
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text( 'KhayalFit is a fitness app that helps you to stay fit and healthy. It provides you with a variety of exercises and diet plans to help you achieve your fitness goals. Our app is designed to be user-friendly and easy to use, so you can focus on your fitness journey without any distractions. Whether you are a beginner or an experienced fitness enthusiast, KhayalFit has something for everyone. So download our app today and start your fitness journey with us!',
          style: GoogleFonts.roboto(
            fontSize: 15,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          ),
        ),
        
  ]));
  }}
