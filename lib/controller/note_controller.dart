import 'package:flutter_application_2/model/hive_database.dart';
import 'package:flutter_application_2/model/note.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class NotesController extends GetxController {
  String mycolor = "#138D75";
  int myIndex = 0;
  final Box _observableBox = BoxRepository.getBox();

  Box get observableBox => _observableBox;

  //gets count of notes
  int get notesCount => _observableBox.length;

  createNote({required Note note}) async {
    await _observableBox.add(note);
    update();
    Get.back();
  }

  updateNote({required int index, required Note note}) async {
    await _observableBox.putAt(index, note);
    update();
    Get.back();
  }

  deleteNote({required int index}) async {
    await _observableBox.deleteAt(index);
    update();
    Get.back();
  }

//----------color-----------------
  selectColor(String color) {
    mycolor = color;
    update();
  }

//-----------------------------
  selectIndex(int index) {
    myIndex = index;
    update();
  }
//-----------------------------
}
