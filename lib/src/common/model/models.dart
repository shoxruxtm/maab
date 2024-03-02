import 'product_model.dart';
import 'resource_model.dart';

class ReportModel {
  String name;
  List<ProductModel>? productList;
  List<ResourceModel>? resourceList;

  ReportModel({
    required this.name,
    this.productList,
    this.resourceList,
  });

  ReportModel copyWith({
    String? name,
    List<ProductModel>? productList,
    List<ResourceModel>? resourceList,
  }) =>
      ReportModel(
        name: this.name,
        productList: this.productList,
        resourceList: this.resourceList,
      );

  factory ReportModel.fromJson(Map<String, Object?> json) => ReportModel(
        name: json["name"] as String,
        productList: json["productList"] != null
            ? List<Map<String, Object?>>.from(json["productList"] as List)
                .map(ProductModel.fromJson)
                .toList()
            : [],
        resourceList: json["resourceList"] != null
            ? List<Map<String, Object?>>.from(json["resourceList"] as List)
                .map(ResourceModel.fromJson)
                .toList()
            : [],
      );

  @override
  String toString() {
    return 'ReportModel{name: $name, productList: $productList, resourceList: $resourceList}';
  }

  Map<String, Object?> toJson() => {
        "name": name,
        "productList": productList,
        "resourceList": resourceList,
      };


}
