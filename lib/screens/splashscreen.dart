

import 'dart:async';

import 'package:calendartask/screens/home.dart';
import 'package:calendartask/utility/assets.dart';
import 'package:calendartask/utility/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomeScreen()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final mwidth=MediaQuery.of(context).size.width;
    final mheight=MediaQuery.of(context).size.height;
    return Container(
      width: mwidth,
      height: mheight,
      color: bodycolor,
      child: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
             splash_image,
              width: mwidth*0.4,
              height: mheight*0.4,
              color: tealcolor,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Calender App',
              style: TextStyle(fontSize: 19.0,
              fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: tealcolor
              ),
            )
          ],
        ),
      ),
    );
  }
}


