import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeaturedId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    this.isFeaturedId = false,
  });

  // Empty Helper Function for Model
  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '', isFeaturedId: false);

  // Json Mapping
  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': name,
      'image': image,
      'parentId': parentId,
      'isFeaturedId': isFeaturedId
    };
  }

  /// Map Json oriented document snapshot from Firebase to User Model
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() != null){
      final data = document.data()!;

      // Map Json Record to Model
      return CategoryModel(
          id: document.id,
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          parentId: data['parentId'] ?? '',
          isFeaturedId: data['isFeaturedId'] ?? false
      );
    }else{
      return CategoryModel.empty();
    }
  }

}
