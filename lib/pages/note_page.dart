import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pdp2_ui/services/hive_database.dart';
import '../model/note_madel.dart';

class NotePage extends StatefulWidget {
  static String id = "note_page";

  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  late List<bool> checkeds = List.generate(listNotes.length, (index) => false);
  bool theme = false, edit = false, selected = false;
  TextEditingController textController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  List<Note> listNotes = [];

  void _createNotes() {
    String title = titleController.text.toString().trim();
    String text = textController.text.toString().trim();
    listNotes.add(Note(id: text.hashCode, createTime: DateTime.now(), content: text, title: title));
    //listNotes.sort((a, b) => b.createTime.compareTo(a.createTime));
    _store();
  }

  Future<void> _store() async {
    checkeds = List.generate(listNotes.length, (index) => false);
    await HiveDataBase.storeNotes(listNotes);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() { listNotes = HiveDataBase.loadNotes();});
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    textController.dispose();
  }

  void _alertDialog([int index = 0]) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(22),
            title: TextField(
              controller: titleController..text = edit ? listNotes[index].title : "New title",
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
            content: TextField(
              controller: textController..text = edit ? listNotes[index].content : "Enter your note!",
              maxLines: 10,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  )),
              TextButton(
                  onPressed: () {
                    if(edit){
                      String title = titleController.text.toString().trim();
                      String text = textController.text.toString().trim();
                      listNotes[index] = Note(id: text.hashCode, createTime: DateTime.now(), content: text, title: title);
                      _store();
                      Navigator.pop(context);
                    }else{
                      _createNotes();
                      Navigator.pop(context);
                      // titleController.clear();
                      // textController.clear();
                    }
                    setState(() {edit = false;});
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  )),
            ],
          );
        });
  }
  void _deleteDialog([int index = 0]) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(22),
            content: Text("Do you want to delete?"),
            actions: [
              TextButton(
                onPressed: () {Navigator.pop(context);},
                child: const Text("CANCEL", style: TextStyle(color: Colors.blue, fontSize: 16),),
              ),
              TextButton(
                onPressed: () {
                  if(selected){
                    List<Note> list = [];
                    for (var i = 0; i < checkeds.length; i++) {
                      if (!checkeds[i]) list.add(listNotes[i]);
                    }
                    listNotes = list;
                    selected = false;
                    _store();
                    setState(() {});
                    Navigator.pop(context);
                  }else {
                    listNotes.removeAt(index);
                    _store();
                    Navigator.pop(context);}
                },
                child: const Text("OK", style: TextStyle(color: Colors.blue, fontSize: 16),),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: theme ? Colors.black : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 64,
        title: Text("Notes", style: TextStyle(color: theme ? Colors.white : Colors.black, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        actions: [
          selected
              ? Container(
            height: 40, width: 40,
            //margin: EdgeInsets.only(right: 15,left: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.04),
            ),
              child: IconButton(
              onPressed: () {
                _deleteDialog();
              },
              icon: Icon(
                Icons.delete,
                color: theme ? Colors.white : Colors.black,
              ),
            ),
          )
              : SizedBox.shrink(),
          Container(
            height: 40, width: 40,
            margin: EdgeInsets.only(right: 15, left: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.04),
            ),
            child: IconButton(
              onPressed: () {setState(() {theme = !theme;});},
              icon: Icon(theme? Icons.light_mode: Icons.dark_mode,
                color: theme ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          /// #Search
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 8,
              top: 4,
            ),
            height: 36,
            decoration: BoxDecoration(
              color:
              theme ? Colors.grey.shade700 : Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: theme ? Colors.white : Colors.black,
                  ),
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle:
                  TextStyle(color: theme ? Colors.white : Colors.black)),
            ),
          ),

          /// #ListView vertical
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listNotes.length,
              itemBuilder: (context, index) {
                return buildSlidable(index);
              }),
        ],
      ),
      /// #FloatingActionButton
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _alertDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Slidable buildSlidable(int index) {
    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        extentRatio: 1 / 6,
        // A motion is a widget used to control how the pane animates.
        motion: ScrollMotion(),
        children: [
          //Spacer(),
          SlidableAction(
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            onPressed: (context) {
              _alertDialog(index);
            setState(() {edit = true;});
            },),
          // MaterialButton(
          //   onPressed: () {
          //     _alertDialog(index);
          //     setState(() {edit = true;});
          //   },
          //   shape: CircleBorder(),
          //   color: Colors.blue,
          //   height: 40,
          //   minWidth: 40,
          //   child: Icon(Icons.edit, color: Colors.white, size: 20),
          // ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        extentRatio: 1/6,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (context) {_deleteDialog(index);},),
          // MaterialButton(
          //   onPressed: () {
          //     _deleteDialog(index);
          //   },
          //   shape: CircleBorder(),
          //   elevation: 0,
          //   color: Colors.red,
          //   height: 40,
          //   minWidth: 40,
          //   child: Icon(Icons.delete, color: Colors.white, size: 20),
          // ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: buildListTile(index),
    );
  }

  ListTile buildListTile(int index) {
    return ListTile(
      tileColor: checkeds[index] ? Colors.blue.withOpacity(0.2) : Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey,),
          Text(listNotes[index].createTime.toString().substring(0, 16),
            style: TextStyle(color: theme ? Colors.white : Colors.black, fontSize: 12, letterSpacing: 0.4,),
          ),
          Text(listNotes[index].title,
            style: TextStyle(color: theme ? Colors.white : Colors.black, fontSize: 17, letterSpacing: 1,),
          ),
        ],
      ),
      subtitle: Text(listNotes[index].content, style: TextStyle(color: Colors.grey),),
      trailing: selected
          ? Checkbox(
        shape: CircleBorder(),
        value: checkeds[index],
        side: BorderSide(color: Colors.grey),
        onChanged: (bool? value) {
          setState(() {
            checkeds[index] = value!;
            selected = true;
          });
        },
      )
          : SizedBox.shrink(),
      onLongPress: () {
        selected = true;
        setState(() {
          checkeds[index] = true;
        });
      },
      onTap: () {
        if (selected) setState(() {checkeds[index] = !checkeds[index];});

        for (var checked in checkeds) {
          if (checked) {
            selected = true; break;
          } else {
            setState(() {selected = false;});
          }
        }
      },
    );
  }
}

