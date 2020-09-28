import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbClient{
  Future<Database> database = null;

  Future<Database> getDatabaseWithCreatedTable() async {
    database = openDatabase(
      // Set the path to the database.
      join(await getDatabasesPath(), 'databaseProfile.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE tblProfile(id INTEGER PRIMARY KEY, mid TEXT, name TEXT, contact TEXT, email TEXT, addresses TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 2,
    );
    return database;
  }

  Future<Database> getUserDataWithTableCreation() async{
    database =openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE tblUserDataWithStoreDetails(id INTEGER PRIMARY KEY, stores TEXT, aaishani_stores TEXT)",
        );
      },
      version: 1,
    );
    return database;
  }

  Future<Database> createTableCart() async{
    database =openDatabase(
      join(await getDatabasesPath(), 'databaseCart.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE tblCartData(id INTEGER PRIMARY KEY, store_id TEXT, product_id TEXT, product_name TEXT, variant TEXT, price TEXT, savings TEXT, qty TEXT)",
        );
      },
      version: 2,
    );
    return database;
  }
}