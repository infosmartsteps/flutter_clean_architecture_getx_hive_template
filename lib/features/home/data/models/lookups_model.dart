class LookupsModel {
  final String id;
  final String value;

  LookupsModel({
    required this.id,
    required this.value,
  });

  factory LookupsModel.fromJson(Map<String, dynamic> json) {
    return LookupsModel(
      id: json["id"],
      value: json["value"],
    );
  }
  // Add a static method to handle list conversion
  static List<LookupsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => LookupsModel.fromJson(item)).toList();
  }
}
