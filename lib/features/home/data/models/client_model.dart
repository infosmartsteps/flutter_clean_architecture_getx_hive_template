// Property Model
class ClientModel {
  final int? id;
  final String? clientName;
  final String? responsiblePerson;
  final String? phoneNumber;
  final String? address;
  final int? registrationNumber;
  final String? responsiblePersonPhone;
  final String? email;
  final double? clientLocationLat;
  final double? clientLocationLng;

  // Dropdown values
  final String? businessSector;
  final String? city;
  final String? informationSource;

  ClientModel({
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
  });

  // Convert to Map
  Map<String?, dynamic> toMap() {
    return {
      'id': id,
      "clientName": clientName,
      "email": email,
      "address": address,
      "clientLocationLat": clientLocationLat,
      "clientLocationLng": clientLocationLng,
      "phoneNumber": phoneNumber,
      "registrationNumber": registrationNumber,
      "responsiblePerson": responsiblePerson,
      "responsiblePersonPhone": responsiblePersonPhone,
      "businessSector": businessSector,
      "city": city,
      "informationSource": informationSource,
    }..removeWhere((key, value) => value == null || value == '');
  }

  // Create from Map
  factory ClientModel.fromMap(Map<String?, dynamic> map) {
    return ClientModel(
      id: map['id'],
      clientName: map["clientName"],
      email: map["email"],
      address: map["address"],
      clientLocationLat: map["clientLocationLat"],
      clientLocationLng: map["clientLocationLng"],
      phoneNumber: map["phoneNumber"],
      registrationNumber: map["registrationNumber"],
      responsiblePerson: map["responsiblePerson"],
      responsiblePersonPhone: map["responsiblePersonPhone"],
      businessSector: map["businessSector"],
      city: map["city"],
      informationSource: map["informationSource"],
    );
  }

  static List<ClientModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ClientModel.fromMap(item)).toList();
  }
}
