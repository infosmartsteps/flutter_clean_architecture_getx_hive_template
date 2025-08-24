class CitiesParameters {
  String country;

  CitiesParameters({required this.country});

  Map<String, dynamic> toJson() => {"country": country}
    ..removeWhere((key, value) => value == null || value == '');
}
