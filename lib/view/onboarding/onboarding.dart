import 'package:flutter/material.dart';

import '../../query/global_handler.dart';
import '../../welcome.dart';
class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Image.asset('assets/onboarding1.png'),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("Budget friendly plans for work from home",
                textAlign: TextAlign.center,
                style:TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 24

              ) ,),
            ),
            SizedBox(height: 25,),
            Text("Our plans are curated to suit your every need. Choose as per your convinience",
                textAlign: TextAlign.center,
                style:   TextStyle(
                    color: Color(0xffB2BDCB),
                    fontWeight: FontWeight.w400,
                    fontSize: 14

                )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration( color: Colors.white),
        child: InkWell(
          onTap: () {
            GlobalHandler.navigatorPushReplacement(context, const WelcomeScreen());
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
            child: const Center(
              child: Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
