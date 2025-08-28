import '../../data/models/client_model.dart';

class ClientEntity {
  final String? id;
  final String? clientName;
  final String? responsiblePerson;
  final String? phoneNumber;
  final String? address;
  final int? registrationNumber;
  final String? responsiblePersonPhone;
  final String? email;
  final double? clientLocationLat;
  final double? clientLocationLng;
  final String? dataUrl;

  // Dropdown values
  final String? businessSector;
  final String? city;
  final String? informationSource;

  ClientEntity({
    this.id,
    this.clientName,
    this.email,
    this.address,
    this.clientLocationLat,
    this.clientLocationLng,
    this.phoneNumber,
    this.registrationNumber,
    this.responsiblePerson,
    this.responsiblePersonPhone,
    this.businessSector,
    this.city,
    this.informationSource,
    this.dataUrl,
  });

  factory ClientEntity.fromResponse(ClientModel response) => ClientEntity(
      id: response.id,
      responsiblePersonPhone: response.responsiblePersonPhone,
      address: response.address,
      businessSector: response.businessSector,
      city: response.city,
      clientLocationLat: response.clientLocationLat,
      clientLocationLng: response.clientLocationLng,
      clientName: response.clientName,
      email: response.email,
      informationSource: response.informationSource,
      phoneNumber: response.phoneNumber,
      registrationNumber: response.registrationNumber,
      responsiblePerson: response.responsiblePerson,
      dataUrl: response.dataUrl);

  static List<ClientEntity> fromModelList(List<ClientModel> modelList) {
    return modelList.map((model) => ClientEntity.fromResponse(model)).toList();
  }
}
