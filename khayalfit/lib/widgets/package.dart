
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Package extends StatefulWidget {
  const Package({
    super.key,
    required this.title,
    required this.description,
    required this.price,

  });
  final String title;
  final String description;
   final String price; 

  @override
  State<Package> createState() => _PackageState();
}

class _PackageState extends State<Package> {
  @override

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return  SizedBox(
      width: 200,
      height: 300,
      child: Card(

        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 4,
          ),

        ),
        
        
          child: Column(children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.title,
                  style: GoogleFonts.abrilFatface(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(padding: const EdgeInsets.all(12),
                child: Text(
                  widget.description,
                  style: GoogleFonts.roboto(
                    fontSize: 12 ,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.price,
                style: GoogleFonts.delaGothicOne(
                  fontSize:  20 ,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            SizedBox(
              
              height: 30,
              ),
            
 ElevatedButton(
                onPressed: () async {
                
                  Uri url = Uri.https('ipn.eg', '/S/moustafa.ibrahim2583/instapay/4T6jD4');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  },
                child: Text(
                      'pay now',
                      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                
                      textStyle: GoogleFonts.abel(
              fontSize: 15,
              fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            
            
             
          
          
          
          ],),
        
      ),


    );
  
  }
}
