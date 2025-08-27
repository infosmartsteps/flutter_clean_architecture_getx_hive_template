import '../../data/models/opportunity_model.dart';
import 'client_entity.dart';
import 'property_entity.dart';

class OpportunityEntity {
  final String id;
  final bool isFollowed;
  final ClientEntity client;
  final PropertyEntity property;

  OpportunityEntity({
    required this.id,
    required this.client,
    required this.property,
    this.isFollowed = false,
  });

  OpportunityEntity copyWith({
    String? id,
    ClientEntity? client,
    PropertyEntity? property,
    bool? isFollowed,
  }) {
    return OpportunityEntity(
      id: id ?? this.id,
      client: client ?? this.client,
      property: property ?? this.property,
      isFollowed: isFollowed ?? this.isFollowed,
    );
  }

  factory OpportunityEntity.fromResponse(OpportunityModel response) =>
      OpportunityEntity(
        id: response.id,
        isFollowed: response.isFollowed,
        property: PropertyEntity.fromResponse(response.property),
        client: ClientEntity.fromResponse(response.client),
      );

  // Add a static method to handle list conversion from models
  static List<OpportunityEntity> fromModelList(List<OpportunityModel> modelList) {
    return modelList.map((model) => OpportunityEntity.fromResponse(model)).toList();
  }
}
