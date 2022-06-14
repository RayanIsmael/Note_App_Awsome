import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/note_controller.dart';
import 'package:flutter_application_2/model/note.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  NotesController controller = Get.find<NotesController>();

  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.mycolor = "#138D75";
    return GetBuilder<NotesController>(builder: (con) {
      return Scaffold(
        backgroundColor: controller.mycolor.hexToColor2(),
        appBar: AppBar(
          title: const Text('Create Note'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: controller.mycolor.hexToColor2(),
          //--------------------
          actions: actionAppBar(),
          //--------------------
        ),
        //----------------
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: myform(),
          ),
        ),
        //----------------
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            if (formkey.currentState!.validate()) {
              Note note = Note(
                title: titleController.text,
                note: noteController.text,
                dateTimeCreated: DateTime.now().toString(),
                dateTimeEdited: DateTime.now().toString(),
                color: controller.mycolor.toString(),
              );
              controller.createNote(note: note);
            } else {
              //print("Error");
            }
          },
          child: Icon(
            Icons.data_saver_on_rounded,
            color: Colors.grey[300],
          ),
        ),
      );
    });
  }

  //-------------------------------------
  myform() {
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
              labelStyle: TextStyle(fontSize: 20, color: Colors.black),
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
              labelStyle: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          //-----------------
          //-------------
        ],
      ),
    );
  }

  List<Widget> actionAppBar() {
    return [
      IconButton(
          onPressed: () {
            Get.bottomSheet(
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          radio(fcolor: "#138D75"),
                          //---------
                          containar(color: "#138D75".hexToColor2()),
                        ],
                      ),
                      //-------------------
                      Row(
                        children: [
                          radio(fcolor: "#FA6161"),
                          //---------
                          containar(color: "#FA6161".hexToColor2()),
                        ],
                      ),
                      //----------------------
                      Row(
                        children: [
                          radio(fcolor: "#FFBB33"),
                          //---------
                          containar(color: "#FFBB33".hexToColor2()),
                        ],
                      ),
                      //----------------------
                      Row(
                        children: [
                          radio(fcolor: "#9BF94D"),
                          //---------
                          containar(color: "#9BF94D".hexToColor2()),
                        ],
                      ),
                      //----------------------
                      Row(
                        children: [
                          radio(fcolor: "#4DF9D4"),
                          //---------
                          containar(color: "#4DF9D4".hexToColor2()),
                        ],
                      ),
                      //----------------------
                    ],
                  ),
                ),
              ),

              //------------------------
              backgroundColor: Colors.grey[800],
              barrierColor: Colors.black.withOpacity(0.4),

              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              //-------------------------
              exitBottomSheetDuration:
                  const Duration(milliseconds: 600), //visible
              enterBottomSheetDuration:
                  const Duration(milliseconds: 400), //unvisible
              //------------------------------
            );
          },
          icon: Icon(
            Icons.settings,
            color: Colors.grey[300],
          ))
    ];
  }

  //-----------------------------------------------
  Widget containar({required Color color}) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  //-------------------------------------------------
  Widget radio({required String fcolor}) {
    return Radio<String>(
      value: fcolor,
      groupValue: controller.mycolor,
      onChanged: (String? color) {
        controller.selectColor(color!);
        Get.back();
      },
    );
  }
}

extension HexToColor on String {
  Color hexToColor2() {
    return Color(
        int.parse(toLowerCase().substring(1, 7), radix: 16) + 0xFF000000);
  }
}
