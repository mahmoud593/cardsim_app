class LevelStructure {
  int? id;
  String? name;
  String? target;
  String? safeTarget;
  String? discount;
  String? image;

  LevelStructure(
      {this.id,
        this.name,
        this.target,
        this.safeTarget,
        this.discount,
        this.image});

  LevelStructure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    target = json['target'];
    safeTarget = json['safe_target'];
    discount = json['discount'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['target'] = this.target;
    data['safe_target'] = this.safeTarget;
    data['discount'] = this.discount;
    data['image'] = this.image;
    return data;
  }
}