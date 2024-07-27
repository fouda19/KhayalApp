import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khayalfit/widgets/package.dart';

class JoinNow extends StatefulWidget {
  @override
  _JoinNowState createState() => _JoinNowState();
}

class _JoinNowState extends State<JoinNow> {
  @override
  Widget build(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Our Packages',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.doHyeon(
                fontSize: 40,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
     
             (width>600)? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Package(
                    title: '6 months',
                    description:
                        'offer you a cutomized diet plan workout plan and iteraction with for 6 months join now ',
                    price: '2700 L.E'),
            SizedBox(
              width: 50,
            ),
            Package(
                title: '3 months',
                description:
                    'offer you a cutomized diet plan workout plan and iteraction with for 3 months join now ',
                price: '1250 L.E'),
            SizedBox(height: 20),
              ],
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Package(
                    title: '6 months',
                    description:
                        'offer you a cutomized diet plan workout plan and iteraction with for 6 months join now ',
                    price: '2700 L.E'),
            SizedBox(
              height:  50,
            ),
            Package(
                title: '3 months',
                description:
                    'offer you a cutomized diet plan workout plan and iteraction with for 3 months join now ',
                price: '1250 L.E'),
            SizedBox(height: 20),
              ],
            ),
            SizedBox(height: 20,)
          

        ],
      )),
    );
  }
}
