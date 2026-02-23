import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
   final String categoryId;
    final String productId;

  ProductCategoryModel({required this.categoryId, required this.productId});

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId
    };
  }

  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;

    return ProductCategoryModel(
        productId : data['productId'] as String,
        categoryId : data['categoryId'] as String
    );
  }
}