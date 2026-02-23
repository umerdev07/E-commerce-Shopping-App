import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  String categoryId;
  String brandId;

  BrandCategoryModel({required this.categoryId, required this.brandId});

  Map<String, dynamic> toJson() {
    return {'categoryId': categoryId, 'brandId': brandId};
  }

  factory BrandCategoryModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return BrandCategoryModel(
      categoryId: data['categoryId'] as String,
      brandId: data['brandId'] as String,
    );
  }
}
