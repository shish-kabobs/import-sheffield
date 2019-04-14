import 'package:flutter/material.dart';
import 'package:flutter_news_web/model/news.dart';
import 'package:flutter_news_web/web_view.dart';

class NewsDetails extends StatefulWidget {
  final Product article;
  final String title;

  NewsDetails(this.article, this.title);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.network(widget.article.image),
                //AssetImage(widget.article.image)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.article.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Instructions: '+widget.article.instructions,
                      style: TextStyle(fontSize: 19.0),
                    ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Origin: '+widget.article.origin,
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Storage: '+widget.article.storage,
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ),
                                                      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Produced by: '+widget.article.produced_by,
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ),
                                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ingredients: '+widget.article.ingredients,
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ),
                                                      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Plastic points: '+widget.article.plastic_points,
                      style: TextStyle(fontSize: 19.0),
                    ),
                  )

                ],
              ),
              // MaterialButton(
              //   height: 50.0,
              //   color: Colors.grey,
              //   child: Text(
              //     "For more news",
              //     style: TextStyle(color: Colors.white, fontSize: 18.0),
              //   ),
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //            WebView(widget.article.url)));
              //   },
              // )
            ],
          ),
        ));
  }
}
