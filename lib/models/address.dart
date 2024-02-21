class Address {
  final String street;
  final String city;
  final String postCode;
  final String coordonnees;

  const Address(this.street, this.city, this.postCode, this.coordonnees);

  factory Address.fromGeoJson(Map<String, dynamic> json) {
    final Map<String, dynamic> properties = json['properties'] ?? {};
    final String street = properties['name'];
    final String city = properties['city'];
    final String postCode = properties['postcode'];
    final String cooX = properties['x'].toString();
    final String cooY = properties['y'].toString();
    final String coordonnees = "$cooX; $cooY";
    return Address(street, city, postCode, coordonnees);
  }
}
