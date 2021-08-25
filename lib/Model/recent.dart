class Recents {
  String title;

  Recents({
    required this.title,
  });

  Recents.fromMap(Map map) : this.title = map['title'];

  Map toMap() {
    return {
      'title': this.title,
    };
  }
}
