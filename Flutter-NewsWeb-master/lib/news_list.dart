import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_web/model/news.dart';
import 'package:flutter_news_web/news_details.dart';
import 'package:http/http.dart' as http;
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

List<Product> products = new List();
class NewsListPage extends StatefulWidget {
  final String title;
  final String newsType;

  NewsListPage(this.title, this.newsType);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}








class _NewsListPageState extends State<NewsListPage> {
  List<Product> list;

  String result = "Hey there !";
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        var response = json.decode(result);
        Product p = new Product(response['name'], response["instructions"], response["storage"], response["ingredients"], response["image"], response["origin"], response["produced_by"], response["plastic_points"]);
        //print(Product.fromJson(response));
        //Product p = Product.fromJson(response);
        print(response);
        print(p);
        products.add(p);
        print(json.decode(result));
        print(products);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }


  @override
  void initState() {
    super.initState();
    if (widget.newsType == "top_news")
      this.getProduct();
    else
      this.getData(widget.newsType);
  }

  Future<String> getProduct() async {
    String link;
    _scanQR();
    return result;
  }

  Future<List<Product>> getData(String newsType) async {

    
    // var res = await http
    //     .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    // print(res.body);
    // setState(() {
    //   if (res.statusCode == 200) {
    //     var data = json.decode(res.body);
    //     var rest = data["articles"] as List;
    //     print(rest);
    //     list = rest.map<Article>((json) => Article.fromJson(json)).toList();
    //   }
    // });
          list = products;
    print("List Size: ${list.length}");
    return list;
  
}

  Widget listViewWidget(List<Product> article) {
    return Container(
      child: ListView.builder(
          itemCount: article.length,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return Card(
              child: Container(
                height: 120.0,
                width: 120.0,
                child: Center(
                  child: ListTile(
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Plastic points earned: ${article[position].plastic_points}',
                      ),
                    ),
                    title: Text(
                      '${article[position].name}',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Container(
                      height: 80.0,
                      width: 80.0,
                      child: article[position].image != null
                          ? Image(
                              image:
                                  //AssetImage('images/no_image_available.png'),
                              AssetImage('${article[position].image}'),
                            )
                          : AssetImage('images/no_image_available.png'),
                    ),
                    onTap: () => _onTapItem(context, article[position]),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _onTapItem(BuildContext context, Product article) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NewsDetails(article, widget.title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: list != null
          ? listViewWidget(list)
          : Center(child: CircularProgressIndicator()),
    );
  }
}


class QR extends StatefulWidget {
  @override
  QRState createState() {
    return new QRState();
  }
}

class QRState extends State<QR> {
  String result = "Hey there !";

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(
          result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
