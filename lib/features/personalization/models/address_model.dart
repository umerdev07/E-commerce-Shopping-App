import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String postalCode;
  final String city;
  final String state;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.postalCode,
    required this.city,
    required this.state,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  static AddressModel empty() => AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    street: '',
    postalCode: '',
    city: '',
    state: '',
    country: '',
    selectedAddress: true,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'postalCode': postalCode,
      'city': city,
      'state': state,
      'country': country,
      'dateTime': dateTime,
      'selectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['id'] as String,
      name: data['name'] as String,
      phoneNumber: data['phoneNumber'] as String,
      street: data['street'] as String,
      postalCode: data['postalCode'] as String,
      city: data['city'] as String,
      state: data['state'] as String,
      country: data['country'] as String,
      selectedAddress: data['selectedAddress'] as bool,
      dateTime: (data['dateTime'] as Timestamp).toDate(),
    );
  }

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      postalCode: data['postalCode'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      country: data['country'] ?? '',
      selectedAddress: data['selectedAddress'] as bool,
      dateTime: (data['dateTime'] as Timestamp).toDate(),
    );
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
