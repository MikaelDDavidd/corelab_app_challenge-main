class Product {
  final int position;
  final String name;
  final String details;
  final double price;
  final double? firstPrice; // Caso tenha oferta
  final int offer;
  final String admissionDate;
  // final double rating;
  final String url;

  Product({
    required this.admissionDate,
    required this.position,
    required this.name,
    required this.details,
    required this.price,
    this.firstPrice,
    required this.offer,
    //  required this.rating,
    required this.url,
  });

  bool get isNew {
    final DateTime admissionDateTime = DateTime.parse(admissionDate);
    final DateTime oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    return admissionDateTime.isAfter(oneWeekAgo);
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      admissionDate: json['admissionDate'] ?? '',
      position: json['position'] ?? 0,
      name: json['name'] ?? '',
      details: json['details'] ?? '',
      price: json['price'] ?? 0,
      firstPrice: json['firstPrice'],
      offer: json['offer'] ?? 0,
      //     rating: json['rating'] ?? 0.0,
      url: json['url'] ?? '',
    );
  }
}
