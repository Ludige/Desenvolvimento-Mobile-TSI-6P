// ignore_for_file: non_constant_identifier_names, unused_field, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:listas/product.dart';

class RegisterProductScreen extends StatefulWidget {
  Product? produto;

  RegisterProductScreen({this.produto});

  @override
  State<RegisterProductScreen> createState() => _RegisterProductScreenState();
}

class _RegisterProductScreenState extends State<RegisterProductScreen> {
  final TextEditingController _title_controller = TextEditingController();
  final TextEditingController _description_controller = TextEditingController();
  final TextEditingController _price_controller = TextEditingController();
  final GlobalKey<FormState> _form_key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.produto != null) {
      setState(() {
        _title_controller.text = widget.produto!.title;
        _description_controller.text = widget.produto!.description;
        _price_controller.text = widget.produto!.price;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.produto == null
            ? Text("Registro de Produto")
            : Text("Edição de Produto"),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _form_key,
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Container(
                    //Placeholder
                    child: SizedBox(
                      height: 75,
                      width: 100,
                      child: Icon(
                        Icons.add_a_photo,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                //Titulo
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: TextFormField(
                  controller: _title_controller,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    labelText: "Nome do Produto",
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo Obrigatorio";
                    }
                  },
                ),
              ),
              Container(
                //Descrição
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: TextFormField(
                  controller: _description_controller,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo Obrigatorio";
                    }
                  },
                ),
              ),
              Container(
                //Preço
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: TextFormField(
                  controller: _price_controller,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    labelText: "Preço",
                    labelStyle: TextStyle(fontSize: 16),
                    prefixText: "R\$",
                    prefixStyle: TextStyle(fontSize: 15),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo Obrigatorio";
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange.shade900),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_form_key.currentState!.validate()) {
                          Product novoProduto = Product(
                            title: _title_controller.text,
                            description: _description_controller.text,
                            price: _price_controller.text,
                          );
                          Navigator.pop(context, novoProduto);
                        }
                      },
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
