import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/note_controller.dart';
import 'package:flutter_application_2/model/note.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  NotesController controller = Get.find<NotesController>();

  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Note note = controller.observableBox.getAt(controller.myIndex);
    titleController.text = note.title;
    noteController.text = note.note;
    return GetBuilder<NotesController>(builder: (con) {
      return Scaffold(
        backgroundColor: controller.mycolor.hexToColor2(),
        appBar: AppBar(
          title: const Text('Edite Note'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: controller.mycolor.hexToColor2(),
          //--------------------
          actions: actionAppBar(note),
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
              Note newnote = Note(
                title: titleController.text,
                note: noteController.text,
                dateTimeCreated: DateTime.now().toString(),
                dateTimeEdited: DateTime.now().toString(),
                color: controller.mycolor.toString(),
              );
              controller.updateNote(index: controller.myIndex, note: newnote);
            } else {
              print("Error");
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
            style: const TextStyle(fontSize: 20, color: Colors.white),
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
              hintStyle: TextStyle(fontSize: 22),
              label: Text("Title"),
              labelStyle: TextStyle(fontSize: 22, color: Colors.black),
            ),
          ),
          //-----------------
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: const TextStyle(fontSize: 20, color: Colors.white),
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
              hintStyle: TextStyle(fontSize: 22),
              label: Text("Content"),
              labelStyle: TextStyle(fontSize: 22, color: Colors.black),
            ),
          ),
          //-----------------
          //-------------
        ],
      ),
    );
  }

  List<Widget> actionAppBar(Note fnote) {
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
                          Expanded(
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
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 15),
                                  child: Text(
                                    "Created :  ${DateFormat("d-M-y").format(DateTime.parse(fnote.dateTimeCreated))}",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  "Last Edited :  ${DateFormat("d-M-y").format(DateTime.parse(fnote.dateTimeEdited))}",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "By:Rayan Aradne",
                          style: TextStyle(
                              fontSize: 18, color: Colors.orange[300]),
                        ),
                      )
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
