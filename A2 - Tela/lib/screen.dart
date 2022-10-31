// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_field, non_constant_identifier_names, prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controle_peso = TextEditingController();
  TextEditingController _controle_altura = TextEditingController();
  String _imc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Não redimencionar a tela quando abrir teclado/ nãprecisa pq ja pois o singleScroll no body, mas deixei aqui pra saber que existe
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Calculadora IMC",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent[100],
          actions: [
            IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _controle_altura.clear();
                  _controle_peso.clear();

                  setState(() {
                    _imc = "";
                  });
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(25),
                  child: TextField(
                      controller: _controle_altura,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text("Altura",
                            style: TextStyle(color: Colors.blueAccent[700])),
                        labelStyle: TextStyle(
                            color: Colors.blueAccent[700], fontSize: 20),
                        prefix: Text("m"),
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: TextField(
                      controller: _controle_peso,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text("Peso",
                            style: TextStyle(color: Colors.blueAccent[700])),
                        labelStyle: TextStyle(
                            color: Colors.blueAccent[700], fontSize: 20),
                        prefix: Text("kg"),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    child: const Text(
                      "IMC",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent[100]),
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      double peso =
                          double.parse(_controle_peso.text.toString());
                      double altura =
                          double.parse(_controle_altura.text.toString());

                      double imc = peso / pow(2, altura);

                      setState(() {
                        if (imc <= 18.5) _imc = "Abaixo do peso";
                        if (imc > 18.5 && imc < 25) _imc = "Peso Ideal";
                        if (imc >= 25 && imc < 30) {
                          _imc = "Levemente acima do peso";
                        }
                        if (imc >= 30 && imc < 35) _imc = "Obesidade grau 1";
                        if (imc >= 35 && imc < 40) _imc = "Obesidade grau 2";
                        if (imc >= 40) _imc = "Obesidade grau 3";
                      });
                    },
                  ),
                ),
                Text(
                  _imc,
                  style: TextStyle(color: Colors.indigo[800], fontSize: 25),
                )
              ],
            ),
          ),
        ));
  }
}
