import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqlbrite/sqlbrite.dart';

Future<BriteDatabase> initDb() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, 'book.db');
  var exists = await databaseExists(path);

  if (!exists) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "book.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    debugPrint("Opening existing database");
  }

  Database db = await openDatabase(path);
  return BriteDatabase(db);
}
