class Item {
  final String id;
  final String name;

  Item({required this.id, required this.name});

  factory Item.fromJson(Map<String, dynamic> json) {
    assert(json['_id'] != null, "Id cannot be null");
    // assert(json['_name'] !=null,"Name cannot be null");
    return Item(
      id: json['_id'],
      name: json['name'],
    );
  }

  // Method to convert Item to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}