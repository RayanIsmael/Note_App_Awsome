import 'package:hive_flutter/hive_flutter.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String note;
  @HiveField(2)
  late String dateTimeCreated;
  @HiveField(3)
  late String dateTimeEdited;
  @HiveField(4)
  late String color ;

  Note({required this.title,required this.note,required this.dateTimeCreated,required this.dateTimeEdited,required this.color});
}
