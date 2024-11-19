import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBCreator {
  //final db = await openDatabase(path, readOnly: true);
  DBCreator._create();
  late Database db;
  set database(Database db) {
    this.db = db;
  }

  Database get database => db;

  static Future<DBCreator> create() async {
    var component = DBCreator._create();
    //init database
    String databasesPath = await getDatabasesPath(); // Get the path to the database
    String path = p.join(databasesPath, 'bitacora.db'); // Join the path with the database name
    // Check if the database exists
    bool exists = await databaseExists(path);
    // If the database does not exist, create it
    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(url.join("assets", "bitacora.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    var db = await openDatabase(path, readOnly: false);
    component.database = db;
    return component;
  }
}
