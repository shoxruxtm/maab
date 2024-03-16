class ResourceModel {
  String? name;
  double? amount;

  ResourceModel({
    this.name,
    this.amount,
  });

  ResourceModel copyWith({
     String? name,
     double? amount,
  }) =>
      ResourceModel(
        name: name ?? this.name,
        amount: amount ?? this.amount,
      );

  factory ResourceModel.fromJson(Map<String, Object?> json)=>ResourceModel(
    name:json["name"] as String,
    amount:json["amount"] as double,
  );

  @override
  String toString() {
    return 'ResourceModel{name: $name, amount: $amount}';
  }

  Map<String, Object?> toJson()=>{
    "name":name,
    "amount":amount,
  };

  bool validate() {
    return name != null && amount != null;
  }
}