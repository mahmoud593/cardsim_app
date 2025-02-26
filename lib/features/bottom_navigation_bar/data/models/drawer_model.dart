class DrawerModel {
  final int id;
  final String title;
  final String slug;

  DrawerModel({
    required this.id,
    required this.title,
    required this.slug,
  });

  factory DrawerModel.fromMap(Map<String, dynamic> json) => DrawerModel(
    id: json["id"]??"",
    title: json["title"]??'',
    slug: json["slug"]??'',
  );

  Map<String, dynamic> toMap() => {
    "id": id??'',
    "title": title??'',
    "slug": slug??'',
  };
}


