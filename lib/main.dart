import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:yaz_lab_1/Model/pc_info_modal.dart';
import 'dart:convert';

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
    int i = 0;
    List links = await getUrls();
    for (var url in links) {
      i++;
      print(url);
      var parseUrl = Uri.parse(url);
      var response = await http.get(parseUrl);
      final body = response.body;
      final doc = parser.parse(body);
      pcinfo.add(Bilgisayarin(
        marka: doc
            .getElementsByClassName("pr-new-br")[0]
            .children[0]
            .text
            .toString(),
        ismi: doc
            .getElementsByClassName("pr-new-br")[0]
            .children[1]
            .text
            .toString(),
        fiyati: doc
            .getElementsByClassName("pr-bx-nm with-org-prc")[0]
            .children[0]
            .text
            .toString(),
        islemciTipi: await getSpesificData(url, 0),
        ssdKapasitesi: await getSpesificData(url, 1),
        isletimSistemi: await getSpesificData(url, 2),
        ekranKarti: await getSpesificData(url, 3),
        ram: await getSpesificData(url, 4),
        cozunurluk: await getSpesificData(url, 5),
        ekranBoyutu: await getSpesificData(url, 6),
        linki: url,
      ));

      if (i == 2) {
        break;
      }
    }
    var json = jsonEncode(pcinfo.map((e) => e.toJson()).toList());
    print(json);
  }

  Future<String> getSpesificData(String thisUrl, int indexx) async {
    var url = Uri.parse(thisUrl);
    late String value;
    var response = await http.get(url);
    final body = response.body;
    final doc = parser.parse(body);
    doc
        .getElementsByClassName("detail-attr-container")[0]
        .getElementsByClassName("detail-attr-item")
        .forEach((element) {
      if (element.children[0].text.toString() == 'İşlemci Tipi' &&
          indexx == 0) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() == 'SSD Kapasitesi' &&
          indexx == 1) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() == 'İşletim Sistemi' &&
          indexx == 2) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() == 'Ekran Kartı' &&
          indexx == 3) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() ==
              'Ram (Sistem Belleği)' &&
          indexx == 4) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() == 'Çözünürlük' &&
          indexx == 5) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() == 'Ekran Boyutu' &&
          indexx == 6) {
        value = element.children[1].text.toString();
      }
    });
    return value;
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
