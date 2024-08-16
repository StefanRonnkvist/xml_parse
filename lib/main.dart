import 'package:flutter/material.dart';
import 'package:xml_parse/xmlParseDocument.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Comity XML',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String stringValue = "Waiting for XML Data....";

  void _loadData() async {
    final buffer = StringBuffer('');
    List<String> newLists = await xmlParseDocument();
    for(String newList in newLists){
      buffer.write("$newList\n");
    }

    setState(() {
      stringValue = buffer.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Comity XML')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(width: 1000, child: Text(stringValue)),
            ],
          ),
        ),
      ),
    );
  }
}
