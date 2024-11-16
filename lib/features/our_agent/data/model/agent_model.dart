class AgentModel {
  final bool status;
  final List<AgentData> data;

  AgentModel({
    required this.status,
    required this.data,
  });

  factory AgentModel.fromMap(Map<String, dynamic> json) => AgentModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<AgentData>.from(json["data"].map((x) => AgentData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class AgentData {
  final int id;
  final String name;
  final String whatsapp;
  final String image;

  AgentData({
    required this.id,
    required this.name,
    required this.whatsapp,
    required this.image,
  });

  factory AgentData.fromMap(Map<String, dynamic> json) => AgentData(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    whatsapp: json["whatsapp"] ?? '',
    image: json["image"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "whatsapp": whatsapp,
    "image": image,
  };
}