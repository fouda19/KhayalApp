import 'package:flutter/material.dart';
import 'package:khayalfit/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:khayalfit/widgets/imageslider.dart';
import 'package:khayalfit/widgets/customeractions.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

@override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children:[ 
                Container(
                height:height*0.8 ,
                width: width,
                child:Image.asset('assets/images/gif.gif',
                              fit: BoxFit.cover,
              ),
              ),]
            ),
            SizedBox(height: 20),
            ImageSlider(),
            SizedBox(height: 20),
            CustomerActions(),
          ],
        ),
      ),
    

   
    );
  }
}
