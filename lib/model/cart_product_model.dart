class CartProductModel {
  final int id;
  final int userId;
  final DateTime date;
  final List<CartItem> products;
  final int version;

  CartProductModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.version,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'products': products.map((item) => item.toJson()).toList(),
      '__v': version,
    };
  }
}

class CartItem {
  final int productId;
  final int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
