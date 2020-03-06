import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:file_selector/file_selector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desktop Plugins',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedFile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desktop Plugins'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: RaisedButton(
              onPressed: () {
                launch('https://google.com');
              },
              child: Text('Open google.com'),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () async {
                final file = await FileSelector().pickFile(
                  type: FileType.any,
                );

                setState(() =>
                    _selectedFile = 'NAME: ${file.name}\nPATH: ${file.path}');
              },
              child: Text('Select file'),
            ),
          ),
          Center(child: Text(_selectedFile)),
        ],
      ),
    );
  }
}
