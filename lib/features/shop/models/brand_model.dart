import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String image;
  bool? isFeatured;
  String name;
  int? productCount;

  BrandModel({
    required this.id,
    required this.image,
    this.isFeatured,
    required this.name,
    this.productCount,
  });

  // Empty Model
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  // Convert Model to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'productCount': productCount,
    };
  }

  factory BrandModel.snapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() != null){
      Map<String,dynamic> data = document.data()!;
      return BrandModel(
          id: data['id'],
          image: data['image'],
          name: data['name'],
          isFeatured: data['isFeatured'],
          productCount: data['productCount'],
      );
    }else{
      return BrandModel.empty();
    }
  }

  factory BrandModel.fromJson(Map<String, dynamic> document){
    final data = document;
    if(data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['id'],
        image: data['image'],
        name: data['name'],
        isFeatured: data['isFeatured'],
        productCount: data['productCount']
    );
  }

}
