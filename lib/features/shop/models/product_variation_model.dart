
class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salesPrice;
  int stock;
  Map<String, String> attributesValues;

  ProductVariationModel({ required this.id, this.sku = '', this.image = '', this.description = '',
    this.price = 0.0, this.salesPrice = 0.0, this.stock = 0, required this.attributesValues});

  static ProductVariationModel empty() => ProductVariationModel(id: '', attributesValues: {});

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'sku': sku,
      'image': image,
      'description': description,
      'price': price,
      'salesPrice': salesPrice,
      'stock': stock,
      'attributesValues': attributesValues
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document){
    final data = document;

    if(data.isEmpty) ProductVariationModel.empty();

    return ProductVariationModel(
      id: data['id'] ?? '',
      sku: data['sku'] ?? '',
      image: data['image'],
      description: data['description'] ?? '',
      price: double.parse((data['price'] ?? 0.0).toString()),
      salesPrice: double.parse((data['salesPrice'] ?? 0.0).toString()),
      stock: data['stock'] ?? 0,
      attributesValues: Map<String, String>.from(data['attributesValues']),
    );
  }

}