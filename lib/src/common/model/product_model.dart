class ProductModel {
  String name;
  int? itemCount;

  ProductModel({
    required this.name,
    required this.itemCount,
  });

  ProductModel copyWith({
    String? name,
    int? itemCount,
  }) =>
      ProductModel(
        name: name ?? this.name,
        itemCount: itemCount ?? this.itemCount,
      );

  factory ProductModel.fromJson(Map<String, Object?> json) => ProductModel(
        name: json["name"] as String,
        itemCount: json["itemCount"] != null ? json["itemCount"] as int : null,
      );

  @override
  String toString() {
    return 'ProductModel{name: $name, itemCount: $itemCount}';
  }

  Map<String, Object?> toJson() => {
        "name": name,
        "itemCount": itemCount,
      };
}
