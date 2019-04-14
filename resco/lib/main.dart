import 'dart:async';
import 'package:flutter/material.dart';
import 'package:resco/categories.dart';
import 'package:resco/news_list.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Categories> categoriesList;

  @override
  void initState() {
    categoriesList = new List<Categories>();
    categoriesList = loadCategories();
    super.initState();
  }

  List<Categories> loadCategories() {
    var categories = <Categories>[
      //adding all the categories of news in the list
      new Categories('images/qricon.png', "Scan", "top_news"),
      new Categories('images/products.png', "My Products", "health"),
      new Categories(
          'images/champion.png', "Achievements", "entertainment"),
      //new Categories('images/sports_news.png', "Summary", "sports")
      //new Categories('images/business_news.png', "Business", "business"),
      //new Categories('images/tech_news.png', "Technology", "technology"),
      //new Categories('images/science_news.png', "Science", "science"),
      //new Categories('images/politics_news.png', "Politics", "politics")
    ];
    return categories;
  }


  String result = "Hey there !";

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        print(result);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
          print(result);
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
          print(result);
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
        print(result);
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
        print(result);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final title = 'Resco';
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GridView.count(
        //body: ListView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this would produce 2 rows.
          crossAxisCount: 3,
          scrollDirection: Axis.horizontal,
          // Generate 100 Widgets that display their index in the List
          children: List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: RaisedButton(
                color: Colors.white,elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0)),
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage(categoriesList[index].image),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: Text(
                        categoriesList[index].title,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                //onPressed: _scanQR
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => NewsListPage(
                          categoriesList[index].title,
                          categoriesList[index].newsType)));

                },

              ),
            );
          }),
        ),
    );
  }
}
