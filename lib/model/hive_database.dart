import 'package:flutter_application_2/model/note.dart';
import 'package:hive_flutter/adapters.dart';

class BoxRepository {
  static const String boxName = "test";
  //-----
  static openBox() async => await Hive.openBox<Note>(boxName);
  //-----
  static Box getBox() => Hive.box<Note>(boxName);
  //-----
  static closeBox() async =>await Hive.box(boxName).close();
}
