class PostOpportunityParameters {
  final String price;
  final String notes;

  PostOpportunityParameters(this.price, this.notes);

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "notes": notes,
    }..removeWhere((key, value) => value == null || value == '');
  }
}
