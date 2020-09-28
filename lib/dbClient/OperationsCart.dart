import 'package:sqflite/sqflite.dart';

import 'DBClient.dart';

class OperationsCart {
  Future<int> insertCartData(
      store_id, product_id, product_name, variant, price, savings, qty) async {
    DbClient dbClient = DbClient();
    final Database db = await dbClient.createTableCart();

    int count = await db.rawInsert(
        "Insert INTO  tblCartData(store_id,product_id,product_name,variant,price,savings,qty) VALUES (?,?,?,?,?,?,?)",
        [
          store_id,
          product_id,
          product_name,
          variant,
          price,
          savings,
          qty
        ]);
    print("Inserted Rows  in tblCartData" + count.toString());
    return count;
  }


  Future<int> getVariantQty(product_id, variant) async {
    DbClient dbClient = DbClient();
    final Database db = await dbClient.createTableCart();
    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT qty FROM tblCartData WHERE product_id=? AND variant=?",
        [product_id, variant]);
     print("result");
     print(result);


    return result.length == 0 ? 0 :int.parse(result[0]['qty'])  ;
  }

  Future<List> getCartData() async {
    DbClient dbClient = DbClient();
    final Database db = await dbClient.createTableCart();

    final List<Map<String, dynamic>> list = await db.query('tblCartData');
    return list;
  }

  Future<int> updateCartData(qty,product_id, variant) async {
    DbClient dbClient = DbClient();
    final Database db = await dbClient.createTableCart();

    int count = await db
        .rawUpdate("UPDATE tblCartData SET qty = ? WHERE product_id=? AND variant=?", [qty,product_id, variant]);
    print("Updated Rows in tblCartData"+ count.toString());
    return count;
  }

  Future<int> deleteCartData() async {
    DbClient dbClient = DbClient();
    final Database db = await dbClient.createTableCart();

    int count = await db.rawDelete('DELETE FROM tblCartData');
    print("Deleted tblCartData" + count.toString());
    return count;
  }

  Future<int> deleteCartItemData(product_id, variant) async {
    DbClient dbClient = DbClient();
    final Database db = await dbClient.createTableCart();

    int count = await db.rawDelete('DELETE FROM tblCartData WHERE product_id=? AND variant = ?', [product_id,variant]);
    print("Deleted  from tblCartData" + count.toString());
    return count;
  }

}
