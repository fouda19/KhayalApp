import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:khayalfit/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CustomerActions extends StatefulWidget {
  const CustomerActions({
    super.key,
  });

  @override
  State<CustomerActions> createState() => _ActionsState();
}

class _ActionsState extends State<CustomerActions> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
        child: Column(
      children: [
        SizedBox(
  width: 200,
  height: 40, // Set your desired width here
  child: ElevatedButton(
    onPressed: () => {},
    child: Text(
      'Login',
      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.secondary,
    
      textStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
SizedBox(height: 10,),
 SizedBox(
  width: 200,
  height: 40, // Set your desired width here
  child: ElevatedButton(
    onPressed: () => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      )
    },
    child: Text(
      'BMR Calculator',
      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      
      textStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
)

      ],
    ));
  }
}
