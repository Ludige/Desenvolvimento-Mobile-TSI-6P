// ignore_for_file: prefer_const_constructors

import 'package:listas/s_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Produtos',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepOrange,
    ),
    home: HomeScreen(),
  ));
}
