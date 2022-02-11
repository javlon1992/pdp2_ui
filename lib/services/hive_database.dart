import 'dart:convert';
import 'package:hive/hive.dart';
import '../model/note_madel.dart';

class HiveDataBase{
  static const String dbName="pdp2_ui";
  static var box = Hive.box(dbName);

  static Future<void> storeNotes(List<Note> noteList) async{
   /// object => map => string
   List<String> stringList = noteList.map((note) => jsonEncode(note.toJson())).toList();
    await box.put("notes", stringList);
  }

  static List<Note> loadNotes() {
    /// string => map => object
    List<String> stringList = box.get("notes") ?? <String>[];
    List<Note> noteList = stringList.map((string) => Note.fromJson(jsonDecode(string))).toList();
    return noteList;
  }

  static Future<void> removeNotes() async{
    await box.delete("notes");
  }

}