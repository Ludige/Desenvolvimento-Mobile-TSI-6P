// ignore_for_file: non_constant_identifier_names, unused_field, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:listas/product.dart';
import 'package:listas/product_helper.dart';
import 'package:listas/s_register_product.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _produtos = List<Product>.empty(growable: true);
  ProductHelper _helper = ProductHelper();

  @override
  void initState() {
    super.initState();

    _helper.getAll().then((data) {
      setState(() {
        if (data != null) {
          _produtos = data;
        }
      });
    });
  }

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

            Product? produtoSalvo = await _helper.saveProduct(produto); //db
            if (produtoSalvo != null) {
              setState(() {
                _produtos.add(produto);

                final snackBar = SnackBar(
                  content: Text('Produto Adicionado: ${produto.title}'),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            }
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, bottom: 15),
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
                          ),
                        ),
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
                  padding: EdgeInsets.only(right: 5, left: 13),
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
                    onDoubleTap: () async {
                      Product produto_modificado = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegisterProductScreen(produto: produto),
                        ),
                      );

                      var result =
                          await _helper.editProduct(produto_modificado);
                      if (result != null) {
                        setState(() {
                          _produtos.removeAt(position);
                          _produtos.insert(position, produto_modificado);

                          final snackBar = SnackBar(
                            content:
                                Text('Produto Modificado: ${produto.title}'),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    },
                    onLongPress: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //Não funcionando por ???? motivos
                                  // ListTile(
                                  //   leading: Icon(
                                  //     Icons.mail,
                                  //     color: Colors.deepOrange,
                                  //   ),
                                  //   title: Text("Enviar por Email"),
                                  //   onTap: () async {
                                  //     Navigator.pop(context);

                                  //     final Uri params = Uri(
                                  //       scheme: 'mailto',
                                  //       path: 'luiggimario2014@gmail.com',
                                  //       queryParameters: {
                                  //         'subject':
                                  //             'Veja o novo ${_produtos[position].title}',
                                  //         'body':
                                  //             'O ${_produtos[position].title}, ${_produtos[position].description} está disponivel por apenas ${_produtos[position].price}',
                                  //       },
                                  //     );
                                  //     final url = params.toString();
                                  //     if (await canLaunchUrl(params)) {
                                  //       await launchUrl(params);
                                  //     } else {
                                  //       throw 'Não foi possivel enviar $url';
                                  //     }
                                  //   },
                                  // ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.message,
                                      color: Colors.deepOrange,
                                    ),
                                    title: Text("Enviar por SMS"),
                                    onTap: () async {
                                      Navigator.pop(context);

                                      final Uri params = Uri(
                                        scheme: 'sms',
                                        path: '+556499294-9698',
                                        queryParameters: {
                                          'body':
                                              'Consega R\$ 15.000 em 3 dias, investindo em ${_produtos[position].title}',
                                        },
                                      );
                                      final url = params.toString();
                                      if (await canLaunchUrl(params)) {
                                        await launchUrl(params);
                                      } else {
                                        print("Não foi possivel enviar $url");
                                      }
                                    },
                                  ),
                                  // ListTile(
                                  //   leading: Icon(Icons.whatsapp),
                                  //   title: Text("Enviar por WHatsapp"),
                                  //   onTap: () async {},
                                  // ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
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
                            onDismissed: (direction) async {
                              var result = await _helper.deleteProduct(produto);
                              if (result != null) {
                                setState(() {
                                  _produtos.removeAt(position);

                                  final snackBar = SnackBar(
                                    content: Text(
                                        'Produto Removido: ${produto.title}'),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 2),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Row(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade400)),
                                      child: SizedBox(
                                        //Image
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.147,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.23,
                                        child: produto.image == null
                                            ? Container(
                                                color: Colors.grey.shade200,
                                                child: Icon(
                                                  Icons.add_a_photo,
                                                  color: Colors.grey.shade700,
                                                ),
                                              )
                                            : Image.file(
                                                produto.image!,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      // TextButton(//Remover
                                      //       onPressed: () {},
                                      //       child: Icon(Icons.clear),
                                      //     )
                                    ),
                                    SizedBox(
                                      //Textos
                                      width: MediaQuery.of(context).size.width *
                                          0.72,
                                      child: Column(
                                        children: [
                                          Container(
                                            //Title
                                            padding: EdgeInsets.only(
                                              left: 10,
                                              bottom: 7,
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                              child: Text(
                                                _produtos[position].title,
                                                style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            //Description
                                            padding: EdgeInsets.only(
                                              left: 10,
                                              bottom: 7,
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.073,
                                              child: Text(
                                                _produtos[position].description,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.grey.shade500,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "R\$ ${_produtos[position].price},00",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange.shade900,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
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
