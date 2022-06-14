import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/hive_database.dart';
import 'package:flutter_application_2/model/note.dart';
import 'package:flutter_application_2/views/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await BoxRepository.openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
