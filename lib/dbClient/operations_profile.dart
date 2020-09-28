import 'package:aaishani_store_user_app/models/profileDataModel.dart';
import 'package:sqflite/sqflite.dart';

import 'DBClient.dart';

class OperationsProfile{
  Future<void> insertProfileData(c) async {
    DbClient dbClient = DbClient();
    final Database db = await dbClient.getDatabaseWithCreatedTable();

    await db.insert(
      'tblProfile',
      c.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<void> deleteProfileData() async {
    DbClient dbClient = DbClient();
    final Database db = await dbClient.getDatabaseWithCreatedTable();

    await db.delete('tblProfile');
  }

  Future<ProfileData> getProfileData() async{
    DbClient dbClient = DbClient();
    final Database db = await dbClient.getDatabaseWithCreatedTable();

    final List<Map<String, dynamic>> list = await db.query('tblProfile');
    ProfileData  profileData=ProfileData.fromJson(list[0]);
    return profileData;
   }

}