import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';

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
  final _sharedPrefController = TextEditingController();

  LocalStorageInterface _localStorage;
  String _selectedFile = '';
  String _prefStatus = '';

  void _initLocalStorage() async {
    _localStorage = await LocalStorage.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desktop Plugins'),
      ),
      body: ListView(
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
                  type: FileType.img,
                );

                setState(() => _selectedFile = file == null
                    ? 'SELECTION CANCELED'
                    : 'NAME: ${file.name}\nPATH: ${file.path}\nBYTES: ${file.bytes.take(10)}...');
              },
              child: Text('Select file'),
            ),
          ),
          Center(child: Text(_selectedFile)),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: TextField(
                controller: _sharedPrefController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type something to store...',
                ),
              ),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () async {
                final result = await _localStorage.setString(
                    'value', _sharedPrefController.text);
                setState(() => _prefStatus = result
                    ? 'Successfuly added to the Shared Prefs'
                    : 'Error occured while adding to the Shared Prefs');
              },
              child: Text('Add to shared prefs'),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                final result = _localStorage.getString('value');
                setState(() =>
                    _prefStatus = 'Retreived value from Shared Prefs: $result');
              },
              child: Text('Get from shared prefs'),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                _localStorage.clear();
                setState(() => _prefStatus = 'Cleared Shared Prefs');
              },
              child: Text('Clear shared prefs'),
            ),
          ),
          Center(child: Text(_prefStatus)),
        ],
      ),
    );
  }
}
