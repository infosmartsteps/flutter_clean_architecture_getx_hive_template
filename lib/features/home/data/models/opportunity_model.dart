import 'client_model.dart';
import 'property_model.dart';

class OpportunityModel {
  final String id;
  final bool isFollowed;
  final ClientModel client;
  final PropertyModel property;

  OpportunityModel({
    required this.id,
    required this.client,
    required this.property,
    this.isFollowed = false,
  });

  OpportunityModel copyWith({
    String? id,
    ClientModel? client,
    PropertyModel? property,
    bool? isFollowed,
  }) {
    return OpportunityModel(
      id: id ?? this.id,
      client: client ?? this.client,
      property: property ?? this.property,
      isFollowed: isFollowed ?? this.isFollowed,
    );
  }

  factory OpportunityModel.fromJson(Map<String, dynamic> json) {
    return OpportunityModel(
      id: json["id"],
      property: json["property"],
      client: json["property"],
      isFollowed: json["property"],
    );
  }

  // Add a static method to handle list conversion
  static List<OpportunityModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => OpportunityModel.fromJson(item)).toList();
  }
}
