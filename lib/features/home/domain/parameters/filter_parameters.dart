class FilterParameters {
  String? clientName;
  String? propertyName;
  String? propertyNumber;
  String? from;
  String? to;

  FilterParameters({
    this.clientName,
    this.from,
    this.to,
    this.propertyName,
    this.propertyNumber,
  });

  Map<String, dynamic> toJson() => {
        "clientName": clientName,
        "propertyName": propertyName,
        "propertyNumber": propertyNumber,
        "from": from,
        "to": to,
      }..removeWhere((key, value) => value == null || value == '');
}
