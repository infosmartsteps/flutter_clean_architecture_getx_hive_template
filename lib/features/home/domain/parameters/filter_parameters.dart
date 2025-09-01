class FilterParameters {
  String? clientName;
  String? from;
  String? to;

  FilterParameters({this.clientName, this.from, this.to});

  Map<String, dynamic> toJson() => {
        "clientName": clientName,
        "from": from,
        "to": to,
      }..removeWhere((key, value) => value == null || value == '');
}
