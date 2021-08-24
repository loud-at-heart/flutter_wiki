class WikiModel {
  WikiModel({this.batchcomplete, this.searchResultContinue, this.query});

  bool? batchcomplete;
  Continue? searchResultContinue;
  Query? query;

  factory WikiModel.fromJson(Map<String, dynamic> json) => WikiModel(
        batchcomplete:
            json["batchcomplete"] == null ? null : json["batchcomplete"],
        searchResultContinue: json["continue"] == null
            ? null
            : Continue.fromJson(json["continue"]),
        query: json["query"] == null ? null : Query.fromJson(json["query"]),
      );

  Map<String, dynamic> toJson() => {
        "batchcomplete": batchcomplete == null ? null : batchcomplete,
        "continue": searchResultContinue == null
            ? null
            : searchResultContinue!.toJson(),
        "query": query == null ? null : query!.toJson(),
      };
}

class Continue {
  Continue({this.gpsoffset, required this.continueContinue});

  final int? gpsoffset;
  final String continueContinue;

  factory Continue.fromJson(Map<String, dynamic> json) => Continue(
        gpsoffset: json["gpsoffset"] == null ? null : json["gpsoffset"],
        continueContinue: json["continue"] == null ? null : json["continue"],
      );

  Map<String, dynamic> toJson() => {
        "gpsoffset": gpsoffset == null ? null : gpsoffset,
        "continue": continueContinue == null ? null : continueContinue,
      };
}

class Query {
  Query({
    this.pages,
  });

  final List<Page>? pages;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        pages: json["pages"] == null
            ? null
            : List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pages": pages == null
            ? null
            : List<dynamic>.from(pages!.map((x) => x.toJson())),
      };
}

class Page {
  Page(
      {this.extract,
      required this.pageid,
      required this.ns,
      required this.url,
      required this.title,
      required this.index,
      this.thumbnail,
      this.terms});

  final String? extract;
  final int pageid;
  final int ns;
  final String url;
  final String title;
  final int index;
  final Thumbnail? thumbnail;
  final Terms? terms;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        pageid: json["pageid"] == null ? null : json["pageid"],
        ns: json["ns"] == null ? null : json["ns"],
        title: json["title"] == null ? null : json["title"],
        index: json["index"] == null ? null : json["index"],
        thumbnail: json["thumbnail"] == null
            ? null
            : Thumbnail.fromJson(json["thumbnail"]),
        extract: json["extract"] == null ? null : json["extract"],
        url: json["fullurl"] == null ? null : json["fullurl"],
        terms: json["terms"] == null ? null : Terms.fromJson(json["terms"]),
      );

  Map<String, dynamic> toJson() => {
        "pageid": pageid == null ? null : pageid,
        "ns": ns == null ? null : ns,
        "title": title == null ? null : title,
        "index": index == null ? null : index,
        "url": url == null ? null : url,
        "extract": extract == null ? null : extract,
        "thumbnail": thumbnail == null ? null : thumbnail!.toJson(),
        "terms": terms == null ? null : terms!.toJson(),
      };
}

class Terms {
  Terms({
    this.description,
  });

  List<String>? description;

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        description: json["description"] == null
            ? null
            : List<String>.from(json["description"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description == null
            ? null
            : List<dynamic>.from(description!.map((x) => x)),
      };
}

class Thumbnail {
  Thumbnail({
    required this.source,
    required this.width,
    required this.height,
  });

  final String source;
  final int width;
  final int height;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        source: json["source"] == null ? null : json["source"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
      );

  Map<String, dynamic> toJson() => {
        "source": source == null ? null : source,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
      };
}
