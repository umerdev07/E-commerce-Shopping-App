import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String email;
  final String username;
  String phoneNumber;
  String profilePicture;
  String publicId;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.profilePicture,
    this.publicId = ''
  });

  String get fullName => '$firstName $lastName';

  static List<String> nameParts(fullname) => fullname.split(" ");

  // static function to create an empty user model
  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    username: '',
    phoneNumber: '',
    profilePicture: '',
      publicId: ''
  );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'Username': username,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'publicId' : publicId
    };
  }

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'],
        lastName: data['LastName'],
        email: data['Email'],
        username: data['Username'],
        phoneNumber: data['PhoneNumber'],
        profilePicture: data['ProfilePicture'],
        publicId: data['publicId']
      );
    } else {
      return UserModel.empty();
    }
  }
}
