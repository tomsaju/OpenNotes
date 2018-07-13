import 'package:flutter/material.dart';
import 'package:open_book/models/Note.dart';
import 'package:open_book/database/DBHelper.dart';


class AddNotePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new AddNotePageState();
  }


}


class AddNotePageState extends State<AddNotePage> {
  final titleController = new TextEditingController();
  final contentController = new TextEditingController();


  void _save(){
    Note note = new Note(titleController.text,contentController.text);
    DBHelper dbHelper = new DBHelper();
    dbHelper.saveNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Add Note"),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.save),onPressed:_save )],
        ),
        body: new Container(

            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Column(

            children: <Widget>[
            new TextField(
                maxLines: 1,
                controller: titleController,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter title'
                )
            ),

            new TextField(
              maxLines: null,
                controller: contentController,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter note',

                )
            )


          ],
        ))
    );
  }
}
