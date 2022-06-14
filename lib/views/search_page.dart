import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/note_controller.dart';
import 'package:flutter_application_2/views/view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class MySearch extends SearchDelegate {
  NotesController controller = Get.find<NotesController>();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //*********************************
    List data = query.isEmpty
        ? controller.observableBox.values.toList()
        : controller.observableBox.values.where((element) {
            return element.title.toLowerCase().contains(query.toLowerCase()) ||
                element.note.toLowerCase().contains(query.toLowerCase());
          }).toList();
    //*********************************
    //-------------------------------------------------------------------------
    return Container(
      color: Colors.grey[600],
      child: GridView.custom(
        gridDelegate: SliverStairedGridDelegate(
          crossAxisSpacing: 48,
          mainAxisSpacing: 24,
          pattern: const [
            StairedGridTile(0.5, 1),
            StairedGridTile(0.5, 3 / 4),
            StairedGridTile(1.0, 10 / 4),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(childCount: data.length,
            (context, index) {
          return GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: data[index].color.toString().mycolor(),
                //################################################################################################
              ),
              child: Column(
                children: [
                  const Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(data[index].title,
                            style: const TextStyle(
                                fontSize: 16.5,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  const Spacer(flex: 5),
                  Flexible(
                    flex: 5,
                    child: Text(data[index].note,
                        style: const TextStyle(
                            fontSize: 14.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis),
                  ),
                  const Spacer(flex: 2),
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
              controller.selectColor(data[index].color);
              controller.myIndex = index;
              Get.to(() => const ViewPage());
            },
          );
        }),
      ),
    );
    //-------------------------------------------------------------------------
  }
}

extension HexToColor on String {
  Color mycolor() {
    return Color(
        int.parse(toLowerCase().substring(1, 7), radix: 16) + 0xFF000000);
  }
}
