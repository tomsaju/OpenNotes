import 'package:flutter/material.dart';
import 'package:open_book/pages/AddNotePage.dart';
import 'package:open_book/database/DBHelper.dart';
import 'dart:async';
import 'package:open_book/models/Note.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Open Book',
      theme: new ThemeData(

        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Open book'),
      routes: <String,WidgetBuilder>{
        '/addPage' : (BuildContext context) =>new AddNotePage(),
      } ,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<List<Note>> fetchNotesFromDatabase() async {
    var dbHelper = new DBHelper();
    Future<List<Note>> notes = dbHelper.getNotes();
    return notes;
  }

  void _newNote(){
    Navigator.of(context).pushNamed('/addPage');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(

          child: new FutureBuilder<List<Note>>(
            future: fetchNotesFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(snapshot.data[index].title,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18.0)),
                            new Text(snapshot.data[index].content,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14.0)),
                            new Divider()
                          ]);
                    });
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);
            },
          )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _newNote,
        tooltip: 'Add a note',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
