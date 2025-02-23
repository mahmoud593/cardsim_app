class MoreModel {
  final bool status;
  final Data data;

  MoreModel({
    required this.status,
    required this.data,
  });

  factory MoreModel.fromMap(Map<String, dynamic> json) => MoreModel(
    status: json["status"],
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data.toMap(),
  };
}

class Data {
  final String title;
  final String slug;
  final String description;

  Data({
    required this.title,
    required this.slug,
    required this.description,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "slug": slug,
    "description": description,
  };
}