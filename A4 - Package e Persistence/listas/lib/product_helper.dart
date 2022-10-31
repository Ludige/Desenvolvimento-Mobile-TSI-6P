import 'package:listas/product.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class ProductHelper {
  static final String tableName = 'products';
  static final String idColumn = 'id';
  static final String titleColumn = 'title';
  static final String descriptionColumn = 'description';
  static final String priceColumn = 'price';
  static final String imagePathColumn = 'image';

  static String get createScript {
    return "CREATE TABLE ${tableName}($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $titleColumn TEXT NOT NULL, $descriptionColumn TEXT NOT NULL, $priceColumn TEXT NOT NULL, $imagePathColumn STRING);";
  }

  Future<Product?> saveProduct(Product produto) async {
    Database? db = await DatabaseHelper().db;
    if (db == null) return null;

    produto.id = await db.insert(tableName, produto.toMap());
    return produto;
  }

  Future<List<Product>?> getAll() async {
    Database? db = await DatabaseHelper().db;
    if (db == null) return null;

    List<Map> todosProdutos = await db.query(tableName, columns: [
      idColumn,
      titleColumn,
      descriptionColumn,
      priceColumn,
      imagePathColumn
    ]);

    List<Product> produtos = List.empty(growable: true);

    for (Map produto in todosProdutos) {
      produtos.add(Product.fromMap(produto));
    }
    return produtos;
  }

  Future<Product?> getByID(int id) async {
    Database? db = await DatabaseHelper().db;
    if (db == null) return null;

    List<Map> todosProdutos = await db.query(
      tableName,
      columns: [
        idColumn,
        titleColumn,
        descriptionColumn,
        priceColumn,
        imagePathColumn
      ],
      where: "$idColumn = ?",
      whereArgs: [id],
    );
    return Product.fromMap(todosProdutos.first);
  }

  Future<int?> editProduct(Product produto) async {
    Database? db = await DatabaseHelper().db;
    if (db == null) return null;

    return await db.update(
      tableName,
      produto.toMap(),
      where: "$idColumn = ?",
      whereArgs: [produto.id],
    );
  }

  Future<int?> deleteProduct(Product produto) async {
    Database? db = await DatabaseHelper().db;
    if (db == null) return null;

    return await db.delete(
      tableName,
      where: "$idColumn = ?",
      whereArgs: [produto.id],
    );
  }
}
