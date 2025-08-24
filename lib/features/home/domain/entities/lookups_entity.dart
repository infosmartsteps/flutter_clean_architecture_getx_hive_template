import '../../data/models/lookups_model.dart';

class LookupsEntity {
  final String  id;
  final String value;

  LookupsEntity({
    required this.id,
    required this.value,
  });

  factory LookupsEntity.fromResponse(LookupsModel response) => LookupsEntity(
        id: response.id,
        value: response.value,
      );

  // Add a static method to handle list conversion from models
  static List<LookupsEntity> fromModelList(List<LookupsModel> modelList) {
    return modelList.map((model) => LookupsEntity.fromResponse(model)).toList();
  }
}
