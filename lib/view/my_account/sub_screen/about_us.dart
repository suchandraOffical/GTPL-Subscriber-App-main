import 'package:flutter/material.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About us",style: TextStyle(color: Color(0xff454748)),),
        leading: BackButton(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
