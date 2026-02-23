class ProductAttributesModel {
  String? name;
  final List<String>? values;

  ProductAttributesModel({this.name, this.values});


  // Json Fomat
  Map<String, dynamic> toJson() {
    return {'name': name, 'values': values};
  }

  factory ProductAttributesModel.fromJson(Map<String, dynamic> document){
    final data = document;

    if(data.isEmpty) return ProductAttributesModel();

    return ProductAttributesModel(
      name: data.containsKey('name') ? data['name'] : '',
      values: List<String>.from(data['values'])
    );

  }
}
