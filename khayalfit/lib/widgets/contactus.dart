import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({
    super.key,
  });

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  bool ishovering = false;
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
        child: Column(children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Contact us',
                style: GoogleFonts.abrilFatface(
                  fontSize: (width > 600) ? 40 : 30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 15,
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child:
                     InkWell(
              onHover: (value) {
                setState(() {
                  ishovering = !ishovering;
                });
              },
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'Omar.hazem.khayal@gmail.com',
                );

                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                } else {
                  print('Could not launch $emailLaunchUri');
                }
              },
              child:  Text(
                      'Omar.hazem.khayal@gmail.com',
                      style: GoogleFonts.actor(
                        fontSize: (width > 600) ? 25 : 15,
                        color:(ishovering)? Theme.of(context).colorScheme.secondary :Theme.of(context).colorScheme.tertiary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ),
                ],
              ),
            
          ),
        ]));
  }
}
