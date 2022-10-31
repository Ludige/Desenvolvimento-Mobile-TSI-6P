// ignore_for_file: non_constant_identifier_names, unused_field, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:listas/product.dart';
import 'package:listas/s_register_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<Product> _produtos = List<Product>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            Product produto = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterProductScreen()),
            );
            setState(() {
              _produtos.add(produto);
            });
          } catch (error) {
            print("Error: ${error.toString()}");
          }
        },
        backgroundColor: Colors.orange[800],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 15),
              child: Text(
                "Produtos",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 40,
              width: 390,
              child: Row(children: [
                Flexible(
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.2,
                        )),
                        //TODO > Nova lista que, quando o usuario digita algo nesse campo
                        //TODO > Muda lista apenas caracteres do RegEx desse campo
                        // alignLabelWithHint: true,
                        labelText: "Pesquisar",
                        labelStyle: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(right: 5, left: 30),
                  child: TextButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white.withOpacity(0),
                    ),
                    child: Icon(
                      Icons.chat,
                      color: Colors.orange.shade900,
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  // padding: EdgeInsets.only(right: 1),
                  child: TextButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white.withOpacity(0),
                    ),
                    child: Icon(
                      Icons.shop,
                      color: Colors.orange.shade900,
                    ),
                  ),
                )
              ]),
            ),
            Flexible(
              child: ListView.separated(
                itemCount: _produtos.length,
                itemBuilder: (context, position) {
                  Product produto = _produtos[position];
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    onLongPress: () async {
                      Product produto_modificado = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegisterProductScreen(produto: produto),
                        ),
                      );
                      if (produto_modificado != null) {
                        setState(() {
                          _produtos.removeAt(position);
                          _produtos.insert(position, produto_modificado);
                        });
                      }
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Dismissible(
                            key: Key(produto.title),
                            background: Container(
                              color: Colors.red,
                              child: const Align(
                                alignment: Alignment(0.9, 0.0),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                _produtos.removeAt(position);
                              });
                            },
                            child: Row(children: [
                              Container(
                                //Placeholder
                                child: SizedBox(
                                  height: 75,
                                  width: 100,
                                  child: Icon(
                                    Icons.add_a_photo,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      //Title
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _produtos[position].title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      //Descriiption
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _produtos[position].description,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey.shade500,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                //Price
                                child: SizedBox(
                                    width: 110,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "R\$",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange.shade900,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${_produtos[position].price},00",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange.shade900,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, position) => Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
