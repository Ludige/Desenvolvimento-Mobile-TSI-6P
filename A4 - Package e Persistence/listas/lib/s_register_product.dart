// ignore_for_file: non_constant_identifier_names, unused_field, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listas/product.dart';
import 'package:path_provider/path_provider.dart';

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

  File? _image;
  int? _id; //

  @override
  void initState() {
    super.initState();

    if (widget.produto != null) {
      setState(() {
        _title_controller.text = widget.produto!.title;
        _description_controller.text = widget.produto!.description;
        _price_controller.text = widget.produto!.price;
        _image = widget.produto!.image;
        _id = widget.produto!.id; //
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
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _form_key,
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    child: _image == null
                        ? Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.15,
                              backgroundColor: Colors.grey.shade400,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                radius:
                                    MediaQuery.of(context).size.width * 0.145,
                                child: CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.06,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage: AssetImage('assets/add.png'),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 20, bottom: 10),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.15,
                              backgroundColor: Colors.grey.shade400,
                              child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.145,
                                backgroundImage: FileImage(_image!),
                              ),
                            ),
                          ),
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? pickedFile =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        File image = File(pickedFile.path);
                        Directory directory =
                            await getApplicationDocumentsDirectory();
                        String _localPath = directory.path;

                        String uniqueID = UniqueKey().toString();

                        final File savedImage =
                            await image.copy('$_localPath/image_$uniqueID.png');

                        setState(() {
                          _image = savedImage;
                        });
                      }
                    },
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
                    maxLength: 25,
                    //TODO > Formatar pr dinheiro
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
                                _title_controller.text,
                                _description_controller.text,
                                _price_controller.text,
                                image: _image,
                                id: _id,
                              );
                              Navigator.pop(context, novoProduto);
                            }
                          },
                          child: Container(
                            child: widget.produto == null
                                ? Text(
                                    "Cadastrar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )
                                : Text(
                                    "Alterar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                          )),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
