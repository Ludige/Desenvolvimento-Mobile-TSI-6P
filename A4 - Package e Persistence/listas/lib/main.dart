// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:listas/s_splash.dart';

void main() {
  runApp(MaterialApp(
    title: 'Produtos',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepOrange,
    ),
    home: SplashScreen(),
  ));
}
