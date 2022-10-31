import 'dart:io';

import 'package:listas/product_helper.dart';

class Product {
  int? id;
  late String title;
  late String description;
  late String price;
  File? image;

  Product(this.title, this.description, this.price, {this.image, this.id});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      ProductHelper.idColumn: this.id,
      ProductHelper.titleColumn: this.title,
      ProductHelper.descriptionColumn: this.description,
      ProductHelper.priceColumn: this.price,
      ProductHelper.imagePathColumn: this.image != null ? this.image!.path : '',
    };
    return map;
  }

  Product.fromMap(Map map) {
    this.id = map[ProductHelper.idColumn];
    this.title = map[ProductHelper.titleColumn];
    this.description = map[ProductHelper.descriptionColumn];
    this.price = map[ProductHelper.priceColumn];
    this.image = map[ProductHelper.imagePathColumn] != ''
        ? File(map[ProductHelper.imagePathColumn])
        : null;
  }
}
  //   Map<String, dynamic> toMap() {
  //   Map<String, dynamic> map = {
  //     'id': id,
  //     'title': title,
  //     'description': description,
  //     'price': price,
  //     'image': image != null ? image!.path : '',
  //   };
  //   return map;
  // }

  // Product.fromMap(Map map) {
  //   id = map['id'];
  //   title = map['title'];
  //   description = map['description'];
  //   price = map['price'];
  //   image = map['image'] != '' ? File(map['image']) : null;
  // }