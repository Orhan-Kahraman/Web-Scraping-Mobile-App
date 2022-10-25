import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:yaz_lab_1/Model/pc_info_modal.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yazlab 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'UcuzcU', denmee: "fdffdsg"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.denmee});
  final String title;
  final String denmee;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var baseUrl = Uri.parse("https://www.trendyol.com/laptop-x-c103108");
  List<Bilgisayarin> pcinfo = [];

  Future getData() async {
    List links = await getUrls();
    for (var url in links) {
      var parseUrl = Uri.parse(url);
      var response = await http.get(parseUrl);
      final body = response.body;
      final doc = parser.parse(body);
      var deneme = doc
          .getElementsByClassName("pr-new-br")[0]
          .children[0]
          .text
          .toString();
      print(deneme);
    }
  }

  Future getUrls() async {
    List urls = [];
    var response = await http.get(baseUrl);
    final body = response.body;
    final doc = parser.parse(body);
    doc
        .getElementsByClassName("prdct-cntnr-wrppr")[0]
        .getElementsByClassName("p-card-wrppr with-campaign-view")
        .forEach((element) {
      urls.add(
          "https://www.trendyol.com/${element.children[0].children[0].attributes['href']}");
    });
    return urls;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
    );
  }
}
