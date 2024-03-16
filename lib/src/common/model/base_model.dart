// class BaseModel{
//   DateTime create;
//   String name;
//   List<ProductModel>? productList;
//   List<ResourceModel>? resourceList;
//
//   ReportModel({
//     required this.name,
//     this.productList,
//     this.resourceList,
//     DateTime? date,
//   }) : date = date ?? DateTime.now();
//
//   ReportModel copyWith({
//     String? name,
//     List<ProductModel>? productList,
//     List<ResourceModel>? resourceList,
//   }) =>
//       ReportModel(
//         name: this.name,
//         productList: this.productList,
//         resourceList: this.resourceList,
//         date: date,
//       );
//
//   factory ReportModel.fromJson(Map<String, Object?> json) => ReportModel(
//       name: json["name"] as String,
//       productList: json["productList"] != null
//           ? List<Map<String, Object?>>.from(json["productList"] as List)
//           .map(ProductModel.fromJson)
//           .toList()
//           : [],
//       resourceList: json["resourceList"] != null
//           ? List<Map<String, Object?>>.from(json["resourceList"] as List)
//           .map(ResourceModel.fromJson)
//           .toList()
//           : [],
//       date: json['date'] != null ? DateTime.parse(json['date'] as String) : null
//   );
//
//   @override
//   String toString() {
//     return 'ReportModel{name: $name, productList: $productList, resourceList: $resourceList}';
//   }
//
//   Map<String, Object?> toJson() => {
//     "name": name,
//     "productList": (productList ?? [] ).map((e) => e.toJson()).toList(),
//     "resourceList": (resourceList ?? []).map((e) => e.toJson()).toList(),
//     "date": date.toIso8601String(),
//   };
//
//
// }
// }