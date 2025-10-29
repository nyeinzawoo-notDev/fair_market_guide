import 'package:flutter/material.dart';
import 'package:fair_market_guide/screens/home_screen.dart';

void main() {
  runApp(FairMarketApp());
}

class FairMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'တရားမျှတသော ဈေးကွက်လမ်းညွှန်',
      theme: ThemeData(
        primaryColor: Colors.green,
        fontFamily: 'Pyidaungsu', // မြန်မာစာလုံး Pyidaungsu အသုံးပြု
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
