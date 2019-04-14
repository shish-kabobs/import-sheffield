class News {
  String status;
  int totalResults;
  List<Article> articles;
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"],
        content: json["content"]);
  }
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }
}

class Product {
  String name;
  String instructions;
  String storage;
  String origin;
  String produced_by;
  String plastic_points;
  String ingredients;
  String image;
  String url;
  String total;

  // Product(
  // {
  //   this.name = name,
  //   this.instructions = instructions,
  //   this.storage = storage,
  //   this.ingredients = ingredients,
  //   this.image = image,
  //   this.url = '',
  //   this.origin = origin,
  //   this.produced_by = produced_by,
  //   this.plastic_points = plastic_points
  // });

    Product(String name, String instructions, String storage, String ingredients, String image, String origin, String produced_by, String plastic_points)
  {
    this.name = name;
    this.instructions = instructions;
    this.storage = storage;
    this.ingredients = ingredients;
    this.image = image;
    this.url = '';
    this.origin = origin;
    this.produced_by = produced_by;
    this.plastic_points = plastic_points;
    this.total = 'Instructions: ';
  }


  //   factory Product.fromJson(Map<String, dynamic> json) {
  //   print("hello");
  //   print(json);
  //   return Product(
  //       name: json["name"],
  //       instructions: json["instructions"],
  //       ingredients: json["ingredients"],
  //       url: '',
  //       image: json["image"],
  //       origin: json["origin"],
  //       produced_by: json["produced_by"],
  //       plastic_points: json["plastic_points"],
  //       storage: json["storage"]);
  // }
}
