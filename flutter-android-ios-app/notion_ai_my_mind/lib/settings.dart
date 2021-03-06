import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
        //primaryColor: Colors.red,
        //backgroundColor: Colors.white,
        //bottomAppBarColor: Colors.white,
      ),
      home: new settingsPage(),
    );
  }
}
class settingsPage extends StatefulWidget {
  @override
  settingsState createState() => settingsState();
}
class settingsState extends State<settingsPage> {
  final myController = TextEditingController();
  String url = " ";
  Future<bool> setUrl(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      url = value;
    });
    return prefs.setString("url", value);
  }

  Future<String> getUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      url = prefs.getString("url") ?? 'name';
    });
    return prefs.getString("url") ?? 'name';
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children: <Widget>[ TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Set url',
                    hintText: url,
                  ),
                  onChanged: (text) {
                    print("First text field: $text");
                  },
                  controller: myController,
                ),
                Text(
                    "Current url: " + url,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]
          )
        ),
        floatingActionButton: FloatingActionButton(
          // When the user presses the button, show an alert dialog containing
          // the text that the user has entered into the text field.
          onPressed: () {
            return showDialog(
              context: context,
              builder: (context) {
                setUrl(myController.text);
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text("Url saved: " + myController.text),
                );

              },
            );
          },
          tooltip: 'Save!',
          child: Icon(Icons.text_fields),
        ),
      ),
    );


  }


}


