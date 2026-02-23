import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageUrl;
  String targetScreen;
  bool active;

  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  // Empty Banner
  static BannerModel empty() =>
      BannerModel(imageUrl: '', targetScreen: '', active: false);

  // ToJson from FireStore
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'targetScreen': targetScreen,
      'active': active,
    };
  }

  // To fetch data snapshot
  factory BannerModel.fromsnapShot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      Map<String, dynamic> data = document.data()!;

      return BannerModel(
        imageUrl: data['imageUrl'] ?? '',
        targetScreen: data['targetScreen'] ?? '',
        active: data['active'] ?? '',
      );
    } else {
      return BannerModel.empty();
    }
  }
}
