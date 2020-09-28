import 'dart:convert';

import 'package:aaishani_store_user_app/models/Model_UserData.dart';
import 'package:sqflite/sqflite.dart';

import 'DBClient.dart';

class OperationsUserAndStoreData {
  Future<int> insertUserData(c) async {
    DbClient dbClient = DbClient();
    final Database db = await dbClient.getUserDataWithTableCreation();
    List<StoresWithCategoriesAndProducts> stores = [];
    for(var i in c.storesWithCategoriesAndProducts)
      {
        stores.add(i);
      }
    String store = jsonEncode(stores);
    List<AaishaniStores> aaishani_stores = [];
    for(var i in c.aaishaniStores)
    {
      aaishani_stores.add(i);
    }
    String aaishaniStores = jsonEncode(aaishani_stores);
    int count = await db
        .rawInsert("Insert INTO  tblUserDataWithStoreDetails(stores,aaishani_stores) VALUES (?,?)", [store,aaishaniStores]);
    print("Inserted Rows  in tblUserDataWithStoreDetails"+ count.toString());
    return count;
  }

  Future<int> updateUserData(c) async {
    DbClient dbClient = new DbClient();
    final Database db = await dbClient.getUserDataWithTableCreation();
    List<StoresWithCategoriesAndProducts> stores = [];
    for(var i in c.storesWithCategoriesAndProducts)
    {
      stores.add(i);
    }
    String store = jsonEncode(stores);
    List<AaishaniStores> aaishani_stores = [];
    for(var i in c.aaishaniStores)
    {
      aaishani_stores.add(i);
    }
    String aaishaniStores = jsonEncode(aaishani_stores);
    int count = await db
        .rawUpdate("UPDATE tblUserDataWithStoreDetails SET stores = ? , aaishani_stores = ? WHERE id = ?", [store,aaishaniStores,1]);
    print("Updated Rows in tblUserDataWithStoreDetails"+ count.toString());
    return count;
  }


  Future<String> getAaishaniStoreData() async{
    DbClient dbClient = DbClient();
    final Database db = await dbClient.getUserDataWithTableCreation();

    final List<Map<String, dynamic>> list = await db.query('tblUserDataWithStoreDetails');
    List<AaishaniStores>  aaishaniStores;
    // =AaishaniStores.fromJson(list['']);
    return list[0]['aaishani_stores'];
  }

  Future<int> getUserData() async{
    DbClient dbClient = DbClient();
    final Database db = await dbClient.getUserDataWithTableCreation();

    final List<Map<String, dynamic>> list = await db.query('tblUserDataWithStoreDetails');
    return list.length;
  }

  Future<List> getStoreData() async{
    DbClient dbClient = DbClient();
    final Database db = await dbClient.getUserDataWithTableCreation();
    final List<Map<String, dynamic>> list = await db.query('tblUserDataWithStoreDetails');
    print("StoresList"+list.toString());
    List<StoresWithCategoriesAndProducts>  storesWithCategoriesAndProducts;
    //=StoresWithCategoriesAndProducts.fromJson(list[0]);
    print("Stores"+storesWithCategoriesAndProducts.toString());
    return list;
  }
}