// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/note_controller.dart';
import 'package:flutter_application_2/model/note.dart';
import 'package:flutter_application_2/views/create_note.dart';
import 'package:flutter_application_2/views/search_page.dart';
import 'package:flutter_application_2/views/view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  NotesController con = Get.put<NotesController>(NotesController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[700],
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MySearch());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      //-----------------------
      body: GetBuilder<NotesController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: one(controller),
        );
      }),
      //-----------------------
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.to(() => CreateNote());
        },
        child: Icon(
          Icons.create,
          color: Colors.grey[300],
        ),
      ),
      //-----------------------
    );
  }

  Widget one(NotesController controller) {
    return GridView.custom(
      gridDelegate: SliverStairedGridDelegate(
        crossAxisSpacing: 48,
        mainAxisSpacing: 24,
        pattern: [
          StairedGridTile(0.5, 1),
          StairedGridTile(0.5, 3 / 4),
          StairedGridTile(1.0, 10 / 4),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
          childCount: controller.notesCount, (context, index) {
        Note note = controller.observableBox.getAt(index);
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: note.color.hexToColor(),
              //################################################################################################
            ),
            child: Column(
              children: [
                Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(note.title,
                          style: TextStyle(
                              fontSize: 16.5,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                Spacer(flex: 4),
                Flexible(
                  flex: 3,
                  child: Text(
                    note.note,
                    style: TextStyle(
                        fontSize: 14.5,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
          //-------------------------------------
          onLongPress: () {
            Get.defaultDialog(
              backgroundColor: Colors.grey[700],
              title: "Worrning",
              titleStyle: const TextStyle(fontSize: 25),
              titlePadding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              //-----------------------
              content: const Text("Do You Want Delete This Note"),
              contentPadding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 20),
              //----------------------
              radius: 10,
              //backgroundColor: Colors.black.withOpacity(0.7),
              //-----------------------
              textConfirm: "Delete", //confirm:  Widge
              textCancel: 'Cancel',
              confirmTextColor: Colors.white,
              cancelTextColor: Colors.white,
              buttonColor: Colors.orange,
              onCancel: () {},
              onConfirm: () {
                controller.deleteNote(index: index);
              },
              //-------------------------
              barrierDismissible: false,
            );
          },
          //------------------
          onTap: () {
            controller.selectColor(note.color);
            controller.myIndex = index;
            Get.to(() => ViewPage());
          },
        );
      }),
    );
  }

  //--------------------------------

  //--------------------------------
  myform(int index, NotesController controller) {
    Note note = controller.observableBox.getAt(index);
    titleController.text = note.title;
    noteController.text = note.note;
    return Form(
      key: formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: titleController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return "isEmpty";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Title",
              hintStyle: TextStyle(fontSize: 20),
              label: Text("Title"),
              labelStyle: TextStyle(fontSize: 20),
            ),
          ),
          //-----------------
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: noteController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return "isEmpty";
              } else {
                return null;
              }
            },
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Content",
              hintStyle: TextStyle(fontSize: 20),
              label: Text("Content"),
              labelStyle: TextStyle(fontSize: 20),
            ),
          ),
          //-----------------
          //-------------
        ],
      ),
    );
  }
}

extension HexToColor on String {
  Color hexToColor() {
    return Color(
        int.parse(toLowerCase().substring(1, 7), radix: 16) + 0xFF000000);
  }
}
