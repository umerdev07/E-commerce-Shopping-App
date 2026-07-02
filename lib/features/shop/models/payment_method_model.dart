class PaymentMethodModel {
  String name;
  String image;

  PaymentMethodModel({
    required this.name,
    required this.image
  });

  static PaymentMethodModel isEmpty() => PaymentMethodModel(name: '', image: '');

}